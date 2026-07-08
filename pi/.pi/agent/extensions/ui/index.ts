import type { ExtensionAPI, ExtensionContext, Theme } from '@earendil-works/pi-coding-agent'

import { VERSION } from '@earendil-works/pi-coding-agent'
import { truncateToWidth, visibleWidth } from '@earendil-works/pi-tui'

const BAR_WIDTH = 12
const LOGO_LINES = [
  '████████████╗',
  '████████████║',
  '████╔═══████║',
  '████║   ████║',
  '████████╬═══████╗',
  '████████║   ████║ ',
  '████╔═══╝   ████║',
  '████║       ████║',
  '╚═══╝       ╚═══╝'
]

function tokens(value: number): string {
  if (value < 1_000) {
    return String(value)
  }
  if (value < 1_000_000) {
    return `${Math.round(value / 1_000)}k`
  }
  return `${(value / 1_000_000).toFixed(1)}M`
}

function usage(ctx: ExtensionContext) {
  return (ctx.sessionManager.getBranch() as any[])
    .filter((entry) => entry.type === 'message' && entry.message?.role === 'assistant')
    .filter((entry) => !['aborted', 'error'].includes(entry.message.stopReason))
    .reduce(
      (total, entry) => {
        const value = entry.message.usage
        if (!value) {
          return total
        }
        total.input += value.input ?? 0
        total.output += value.output ?? 0
        total.cache += (value.cacheRead ?? 0) + (value.cacheWrite ?? 0)
        total.cost += value.cost?.total ?? 0
        return total
      },
      { cache: 0, cost: 0, input: 0, output: 0 }
    )
}

function row(width: number, left: string, right = ''): string {
  const inner = Math.max(0, width - 2)
  const finalRight = truncateToWidth(right, inner)
  const availableLeft = Math.max(0, inner - visibleWidth(finalRight) - (finalRight ? 1 : 0))
  const finalLeft = truncateToWidth(left, availableLeft)
  return ` ${finalLeft}${' '.repeat(Math.max(0, inner - visibleWidth(finalLeft) - visibleWidth(finalRight)))}${finalRight} `
}

function gradient(theme: Theme, percent: number): string {
  const filled = Math.round((Math.min(100, Math.max(0, percent)) / 100) * BAR_WIDTH)
  return theme.fg('accent', '▋'.repeat(filled)) + theme.fg('dim', '▋'.repeat(BAR_WIDTH - filled))
}

function header(
  theme: Theme,
  ctx: ExtensionContext,
  commands: Array<{ source: string }>,
  terminalWidth: number
): string[] {
  if (!ctx.hasUI) {
    return []
  }

  const width = Math.min(76, terminalWidth)
  const extensionCount = commands.filter((command) => command.source === 'extension').length
  const skillCount = commands.filter((command) => command.source === 'skill').length
  const promptCount = commands.filter((command) => command.source === 'prompt').length
  const model = ctx.model?.name ?? ctx.model?.id ?? 'no model'
  const border = (text: string) => theme.fg('dim', text)
  const muted = (text: string) => theme.fg('muted', text)
  const title = ` ${theme.fg('accent', 'π')} ${muted(`pi ${VERSION}`)} `
  const lines = [
    '',
    `${border('╭')}${title}${border('─'.repeat(Math.max(0, width - 2 - visibleWidth(title))))}${border('╮')}`,
    `${border('│')}${border(' '.repeat(width - 2))}${border('│')}`
  ]
  const details = [
    '',
    '',
    ` ${theme.fg('accent', model)}`,
    ` ${extensionCount} extensions · ${skillCount} skills · ${promptCount} prompts`,
    ` ${muted('/')} commands · ${muted('!')} bash`,
    `${muted('ctrl+o')} tool details · ${muted('ctrl+t')} thinking`,
    ` ${muted(ctx.cwd)}`
  ]

  for (let index = 0; index < LOGO_LINES.length; index++) {
    const left = theme.fg('accent', LOGO_LINES[index]!)
    const right = details[index] ?? ''
    const content = `${left}${' '.repeat(Math.max(1, 18 - visibleWidth(left)))}${right}`
    lines.push(`${border('│')}  ${truncateToWidth(content, width - 4)}${' '.repeat(Math.max(0, width - 4 - visibleWidth(content)))}${border('│')}`)
  }

  lines.push(
    `${border('│')}${border(' '.repeat(width - 2))}${border('│')}`,
    `${border('╰')}${border('─'.repeat(width - 2))}${border('╯')}`,
    ''
  )
  return lines
}

export default function pikitUi(pi: ExtensionAPI) {
  let ctx: ExtensionContext | undefined

  pi.on('session_start', (_, nextCtx) => {
    ctx = nextCtx
    if (!ctx.hasUI) {
      return
    }

    ctx.ui.setHeader((_tui, theme) => ({
      invalidate() { },
      render: (width) => width < 56 ? [] : header(theme, ctx!, pi.getCommands(), width)
    }))

    ctx.ui.setFooter((_tui, theme, _footerData) => ({
      invalidate() { },
      render(width) {
        const total = usage(ctx!)
        const context = ctx!.getContextUsage()
        const window = ctx!.model?.contextWindow ?? 0
        const percent = context?.tokens && window ? (context.tokens / window) * 100 : 0
        const model = ctx!.model?.name ?? ctx!.model?.id ?? 'no model'
        const topLeft = `${theme.fg('accent', 'π')} ${theme.fg('text', model)} ${theme.fg('dim', ctx!.cwd.split('/').at(-1) ?? ctx!.cwd)}`
        const topRight = `${gradient(theme, percent)} ${theme.fg('muted', `${percent.toFixed(1)}% / ${tokens(window)}`)}`
        const thinking = pi.getThinkingLevel().toUpperCase()
        const bottomLeft = `${theme.fg('dim', 'Thinking:')} ${theme.fg('accent', thinking)} ${theme.fg('dim', 'Ponytail:')} ${theme.fg('error', 'ULTRA')}`
        const totalTokens = total.input + total.output + total.cache
        const bottomRight = `${theme.fg('dim', 'T:')} ${theme.fg('muted', tokens(totalTokens))} ${theme.fg('dim', `(cached ${tokens(total.cache)}) ↑ ${tokens(total.input)} ↓ ${tokens(total.output)} | $${total.cost.toFixed(3)}`)}`
        return ['', row(width, topLeft, topRight), theme.fg('dim', '─'.repeat(width)), row(width, bottomLeft, bottomRight)]
      }
    }))
  })
}
