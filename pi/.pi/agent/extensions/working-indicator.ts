import type { ExtensionAPI } from '@earendil-works/pi-coding-agent'

export default function workingIndicator(pi: ExtensionAPI) {
  pi.on('session_start', (_, ctx) => {
    ctx.ui.setWorkingIndicator({
      frames: [
        '□□□□□',
        '■□□□□',
        '■■□□□',
        '■■■□□',
        '■■■■□',
        '■■■■■',
        '■■■■□',
        '■■■□□',
        '■■□□□',
        '■□□□□'
      ],
      intervalMs: 80
    })
  })
}
