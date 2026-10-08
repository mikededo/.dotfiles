import type { ExtensionAPI } from '@earendil-works/pi-coding-agent'

const WIDTH = 7
const INTERVAL = 32
const CYCLES = 4 // cycles generated per loop, so jitter varies between repeats
const HEAD = '▓'
const TRAIL = ['▒', '░'] // closest to head → farthest, each smaller
const EMPTY = '·'
const TRAIL_LAG = 3 // ticks of history the trail reaches back

// Timings, in ticks (× INTERVAL ms)
const TURN = 1 // pause at the far edge in the there-and-back
const SHORT_WAIT = 5 // ~160ms after the there-and-back

// Softer than cubic: gentle acceleration and landing
const easeInOutSine = (t: number) => -(Math.cos(Math.PI * t) - 1) / 2
// Mild overshoot that settles back, used occasionally
const easeOutBackSoft = (t: number) => {
  const c1 = 0.8
  return 1 + (c1 + 1) * (t - 1) ** 3 + c1 * (t - 1) ** 2
}

const toCell = (p: number) => Math.min(WIDTH - 1, Math.max(0, Math.floor(p)))

// Head at `head`, trail grows behind it toward where it was `TRAIL_LAG` ticks ago
const render = (head: number, lagged: number) => {
  const cells = Array.from({ length: WIDTH }).fill(EMPTY)
  const dir = Math.sign(head - lagged)
  const length = Math.min(TRAIL.length, Math.abs(head - lagged))
  for (let i = 1; i <= length; i++) {
    const idx = head - dir * i
    if (idx >= 0 && idx < WIDTH) {
      cells[idx] = TRAIL[i - 1]
    }
  }
  cells[head] = HEAD
  return cells.join('')
}

const LEFT = 0.5
const RIGHT = WIDTH - 0.5

const buildFrames = () => {
  const positions: number[] = []
  let pos = LEFT

  const sweep = (target: number) => {
    const dist = Math.abs(target - pos)
    // Small jitter in duration keeps sweeps from feeling metronomic
    const steps = Math.round(dist * 2.4 + 2 + Math.random() * 4)
    const ease = Math.random() < 0.3 ? easeOutBackSoft : easeInOutSine
    for (let k = 1; k <= steps; k++) {
      positions.push(pos + (target - pos) * ease(k / steps))
    }
    pos = target
  }

  const hold = (n: number) => {
    for (let k = 0; k < n; k++) {
      positions.push(pos)
    }
  }

  for (let c = 0; c < CYCLES; c++) {
    sweep(RIGHT)
    hold(TURN)
    sweep(LEFT)
    hold(SHORT_WAIT)
    sweep(RIGHT)
    sweep(LEFT)
  }

  return positions.map((p, i) =>
    render(toCell(p), toCell(positions[i - TRAIL_LAG] ?? LEFT))
  )
}

export default function workingIndicator(pi: ExtensionAPI) {
  pi.on('session_start', (_, ctx) => {
    const theme = ctx.ui.theme
    const borderColor = theme.getThinkingBorderColor('off')
    const frames = buildFrames().map((frame) => borderColor(frame))
    ctx.ui.setWorkingIndicator({ frames, intervalMs: INTERVAL })
  })
}
