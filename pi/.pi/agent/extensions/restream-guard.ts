import type { ExtensionAPI } from '@earendil-works/pi-coding-agent'

import { execFileSync } from 'node:child_process'
import { existsSync, realpathSync } from 'node:fs'
import { homedir } from 'node:os'
import { basename, join, relative, sep } from 'node:path'

// Restream forbids models hosted outside the EU/US, and some OpenCode models are.
const BLOCKED_PROVIDERS = new Set(['opencode', 'opencode-go'])
const HOME = homedir()
const WORK_DIR = join(HOME, 'Documents', 'work')
const T3_WORKTREES = join(HOME, '.t3', 'worktrees')
// Text that points at restream: work paths (also ~/ and $HOME forms), restream MCP servers, the GitHub org.
const RESTREAM_TEXT = /Documents\/work\b|restream|\.t3\/worktrees\/(?:restream|clips|klap|studio|static-pages)/i

type Model = { provider: string, id: string }

const under = (path: string, dir: string) => {
  const rel = relative(dir, path)
  return rel !== '' && !rel.startsWith('..') && !rel.startsWith(sep)
}

const cwdCache = new Map<string, boolean>()
const isRestreamCwd = (cwd: string) => {
  if (!cwdCache.has(cwd)) {
    let hit = true // fail closed
    try {
      const real = realpathSync(cwd)
      // jj workspaces live next to the repo in ~/Documents/work; T3 worktrees are ~/.t3/worktrees/<repo>/<id>
      const t3Repo = under(real, T3_WORKTREES) ? relative(T3_WORKTREES, real).split(sep)[0] : undefined
      hit = under(real, WORK_DIR)
        || (!!t3Repo && existsSync(join(WORK_DIR, t3Repo)))
        || /restreamio/i.test(remotes(real))
    } catch {}
    cwdCache.set(cwd, hit)
  }
  return cwdCache.get(cwd)!
}

const remotes = (cwd: string) => {
  try {
    return execFileSync('git', ['remote', '-v'], { cwd, encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'], timeout: 3000 })
  } catch {
    return ''
  }
}

const isOpenCode = (model: Model | undefined): model is Model => !!model && BLOCKED_PROVIDERS.has(model.provider)

const reason = (model: Model, what: string) =>
  `${model.provider}/${model.id} is blocked for restream (${what}): OpenCode models may be hosted outside the EU/US.`

export default function restreamGuard(pi: ExtensionAPI) {
  // Every run starts from an input (typed, T3/RPC or extension). Block it when the session sits in a
  // restream checkout, or when the prompt points at one (a delegate briefed with a workspace path).
  pi.on('input', (event, ctx) => {
    if (!isOpenCode(ctx.model)) return
    const what = isRestreamCwd(ctx.cwd) ? `cwd ${basename(ctx.cwd)}` : RESTREAM_TEXT.test(event.text) ? 'prompt mentions restream' : undefined
    if (!what) return
    ctx.ui.notify(reason(ctx.model, what), 'error')
    return { action: 'handled' }
  })

  // A tool call that reaches restream (a path, a cd, a restream MCP server) stops the run before
  // its result enters the context.
  pi.on('tool_call', (event, ctx) => {
    if (!isOpenCode(ctx.model)) return
    if (!RESTREAM_TEXT.test(`${event.toolName} ${JSON.stringify(event.input)}`)) return
    return { block: true, reason: reason(ctx.model, `tool ${event.toolName}`), terminate: true }
  })

  // Switching to a blocked model inside a restream checkout reverts to the previous one.
  pi.on('model_select', async (event, ctx) => {
    if (!isOpenCode(event.model) || !isRestreamCwd(ctx.cwd)) return
    ctx.ui.notify(reason(event.model, `cwd ${basename(ctx.cwd)}`), 'error')
    if (event.previousModel) await pi.setModel(event.previousModel)
  })
}
