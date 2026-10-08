import type { ExtensionAPI, ExtensionContext } from '@earendil-works/pi-coding-agent'

// Knight Rider scanner, ported from opencode (packages/tui/src/ui/spinner.ts)
const WIDTH = 8
const INTERVAL = 40
const TRAIL = 6 // lit cells counted from the head, head included
const HOLD_START = 30 // frames held at the left edge
const HOLD_END = 9 // frames held at the right edge
const ACTIVE = '■'
const IDLE = '·'

type Theme = ExtensionContext['ui']['theme']

const dim = (text: string) => `\x1B[2m${text}\x1B[22m`

// Mirrors opencode's bidirectional scanner: forward, hold, backward, hold
const buildFrames = (theme: Theme) => {
  const forward = WIDTH
  const backward = WIDTH - 1
  const total = forward + HOLD_END + backward + HOLD_START

  const cell = (index: number) => {
    if (index === 0) {
      return theme.fg('accent', ACTIVE)
    }
    if (index > 0 && index < TRAIL) {
      return dim(theme.fg('accent', ACTIVE))
    }
    return dim(theme.fg('accent', IDLE))
  }

  return Array.from({ length: total }, (_, frame) => {
    let active = 0
    let holdProgress = 0
    let isHolding = false
    let isForward = true

    if (frame < forward) {
      active = frame
    } else if (frame < forward + HOLD_END) {
      active = WIDTH - 1
      holdProgress = frame - forward
      isHolding = true
    } else if (frame < forward + HOLD_END + backward) {
      active = WIDTH - 2 - (frame - forward - HOLD_END)
      isForward = false
    } else {
      holdProgress = frame - forward - HOLD_END - backward
      isHolding = true
      isForward = false
    }

    return Array.from({ length: WIDTH }, (_, char) => {
      const distance = isForward ? active - char : char - active
      if (isHolding) {
        return cell(distance + holdProgress)
      }
      return cell(distance)
    }).join('')
  })
}

export default function workingIndicator(pi: ExtensionAPI) {
  pi.on('session_start', (_, ctx) => {
    ctx.ui.setWorkingIndicator({ frames: buildFrames(ctx.ui.theme), intervalMs: INTERVAL })
  })
}
