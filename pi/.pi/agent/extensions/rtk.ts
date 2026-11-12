// RTK Pi extension — rewrites bash commands to use rtk for token savings.
// Requires: rtk >= 0.23.0. Resolved from PATH, then Homebrew, so a thin
// T3 PATH cannot disable it.
//
// Rewrite rules live in `rtk rewrite`. This file only removes truncation
// pipes (`| head`, `| tail`, `2>&1 | tail`) that stop a rewrite from matching
// and then discard rtk's summary. If rewrite finds nothing, the original
// command runs unchanged.

import type { ExtensionAPI } from '@earendil-works/pi-coding-agent'

import { isToolCallEventType } from '@earendil-works/pi-coding-agent'
import { accessSync, constants } from 'node:fs'
import { delimiter } from 'node:path'
import process from 'node:process'

const REWRITE_TIMEOUT_MS = 2_000
const MIN_SUPPORTED_RTK_MINOR = 23

function parseSemver(raw: string): [number, number, number] | null {
  const m = raw.trim().match(/(\d+)\.(\d+)\.(\d+)/)
  if (!m) {
    return null
  }
  return [Number.parseInt(m[1], 10), Number.parseInt(m[2], 10), Number.parseInt(m[3], 10)]
}

function findRtk(): string | null {
  const dirs = (process.env.PATH ?? '').split(delimiter).filter(Boolean)
  const candidates = [
    ...dirs.map((dir) => `${dir}/rtk`),
    '/opt/homebrew/bin/rtk',
    '/usr/local/bin/rtk'
  ]
  for (const candidate of candidates) {
    try {
      accessSync(candidate, constants.X_OK)
      return candidate
    } catch {
      // next candidate
    }
  }
  return null
}

// Truncation only. `| wc` and `| grep` stay: they change the result.
export function stripTruncation(cmd: string): string {
  return cmd
    .replace(/\s*2>&1\s*\|\s*(?:head|tail)\b[^;&|]*/g, '')
    .replace(/\s*\|\s*(?:head|tail)\b[^;&|]*/g, '')
}

function useAbsoluteRtk(rewritten: string, rtkBin: string): string {
  return rewritten.replace(/(^|[\s;&|])rtk(?=\s)/g, `$1${rtkBin}`)
}

async function rewriteCommand(
  pi: ExtensionAPI,
  rtkBin: string,
  cmd: string,
  signal?: AbortSignal
): Promise<null | string> {
  const result = await pi.exec(rtkBin, ['rewrite', cmd], {
    signal,
    timeout: REWRITE_TIMEOUT_MS
  })
  if (result.killed) {
    return null
  }
  if (result.code !== 0 && result.code !== 3) {
    return null
  }
  return result.stdout.trim() || null
}

export default async function (pi: ExtensionAPI) {
  const rtkBin = findRtk()
  if (!rtkBin) {
    console.warn('[rtk] rtk binary not found — extension disabled')
    return
  }

  const ver = await pi.exec(rtkBin, ['--version'], { timeout: REWRITE_TIMEOUT_MS })
  if (ver.code !== 0) {
    console.warn('[rtk] rtk --version failed — extension disabled')
    return
  }

  const parsed = parseSemver(ver.stdout.replace(/^rtk\s+/, ''))
  if (parsed) {
    const [major, minor] = parsed
    if (major === 0 && minor < MIN_SUPPORTED_RTK_MINOR) {
      console.warn(`[rtk] rtk ${ver.stdout.trim()} is too old (need >= 0.23.0) — extension disabled`)
      return
    }
  }

  pi.on('tool_call', async (event, ctx) => {
    try {
      if (!isToolCallEventType('bash', event)) {
        return
      }

      const cmd = event.input.command
      if (typeof cmd !== 'string' || cmd.trim() === '') {
        return
      }

      if (process.env.RTK_DISABLED === '1') {
        return
      }

      const prepared = stripTruncation(cmd)
      const rewritten = await rewriteCommand(pi, rtkBin, prepared, ctx.signal)
      if (!rewritten || rewritten === cmd) {
        return
      }
      event.input.command = useAbsoluteRtk(rewritten, rtkBin)
    } catch (err) {
      console.warn('[rtk] unexpected error in tool_call handler; passing through command', err)
    }
  })
}
