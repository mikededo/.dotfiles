import type { ExtensionAPI, ExtensionContext } from '@earendil-works/pi-coding-agent'

import { readFileSync, rmSync, writeFileSync } from 'node:fs'
import { homedir } from 'node:os'
import { join } from 'node:path'

// When Claude has no access (quota or auth), every Pi session, the lead and its T3 children, moves to Sol
// and continues. The pause is shared through a file so new sessions start on Sol instead of failing first.
const FALLBACK = { id: 'gpt-6.2-sol', provider: 'openai-codex' }
const STATE = join(homedir(), '.pi', 'agent', 'claude-fallback.json')
// shortcut: a fixed one-hour pause, then the next session probes Claude again (one failed run). Pi fires no
// after_provider_response for Anthropic's 429, so its reset header is out of reach; read it if Pi ever exposes it.
const PAUSE_MS = 60 * 60 * 1000
// Errors left after Pi's own retries that mean "no access". Overloaded and invalid requests are not access problems.
export const ACCESS_ERROR = /rate.?limit|usage.?limit|(?<!\d)(?:401|403|429)(?!\d)|authentication|oauth|credential|permission_error|billing|credit balance/i

type Assistant = { role: 'assistant', provider: string, stopReason: string, errorMessage?: string }

const pausedUntil = () => {
  try {
    return Number(JSON.parse(readFileSync(STATE, 'utf8')).until) || 0
  } catch {
    return 0
  }
}

const lastAssistant = (ctx: ExtensionContext) => {
  const branch = ctx.sessionManager.getBranch()
  for (let i = branch.length - 1; i >= 0; i--) {
    const entry = branch[i]
    if (entry.type === 'message' && entry.message.role === 'assistant') {
      return entry.message as unknown as Assistant
    }
  }
}

export default function claudeFallback(pi: ExtensionAPI) {
  const toSol = async (ctx: ExtensionContext, why: string) => {
    const sol = ctx.modelRegistry.find(FALLBACK.provider, FALLBACK.id)
    if (!sol || !(await pi.setModel(sol))) {
      ctx.ui.notify(`Claude unavailable (${why}) and ${FALLBACK.id} has no auth`, 'error')
      return false
    }
    ctx.ui.notify(`Claude unavailable (${why}): switched to ${FALLBACK.id}`, 'warning')
    return true
  }

  // Every run starts from an input: while Claude is paused, a Claude session moves to Sol before it spends a request.
  pi.on('input', async (_event, ctx) => {
    if (ctx.model?.provider === 'anthropic' && Date.now() < pausedUntil()) {
      await toSol(ctx, `paused until ${new Date(pausedUntil()).toLocaleTimeString()}`)
    }
  })

  // A run that ended on a Claude access error records the pause, switches to Sol and resumes the task.
  pi.on('agent_settled', async (event, ctx) => {
    if (event.aborted) {
      return
    }
    const message = lastAssistant(ctx)
    if (message?.provider !== 'anthropic' || message.stopReason !== 'error') {
      return
    }
    const error = message.errorMessage ?? ''
    if (!ACCESS_ERROR.test(error)) {
      return
    }
    writeFileSync(STATE, JSON.stringify({ error: error.slice(0, 300), until: Date.now() + PAUSE_MS }))
    if (await toSol(ctx, error.slice(0, 80))) {
      pi.sendUserMessage(`Claude has no access (${error.slice(0, 200)}). This session now runs on ${FALLBACK.id}. Continue the task from where it stopped.`)
    }
  })

  pi.registerCommand('claude-fallback', {
    description: 'Show the Claude → Sol pause, or clear it with `off`',
    handler: async (args, ctx) => {
      if (args.trim() === 'off') {
        rmSync(STATE, { force: true })
        ctx.ui.notify('Claude pause cleared', 'info')
        return
      }
      const until = pausedUntil()
      ctx.ui.notify(Date.now() < until ? `Claude paused until ${new Date(until).toLocaleString()}` : 'Claude not paused', 'info')
    }
  })
}
