import type { ExtensionAPI } from '@earendil-works/pi-coding-agent'

import { unlink } from 'node:fs/promises'

export default function forget(pi: ExtensionAPI) {
  pi.registerCommand('forget', {
    description: 'Delete the current chat and start a new session',
    handler: async (_args, ctx) => {
      await ctx.waitForIdle()
      const sessionFile = ctx.sessionManager.getSessionFile()

      await ctx.newSession({
        withSession: async (nextCtx) => {
          if (sessionFile) {
            await unlink(sessionFile).catch((error: NodeJS.ErrnoException) => {
              if (error.code !== 'ENOENT') {
                throw error
              }
            })
          }
          nextCtx.ui.notify('Forgot current chat', 'info')
        }
      })
    }
  })
}
