import type { ExtensionAPI } from '@earendil-works/pi-coding-agent'

import { readFileSync } from 'node:fs'
import { homedir } from 'node:os'
import { join } from 'node:path'

// Standing rules per model family, kept in the vault: model id fragment → file.
const RULES_DIR = join(homedir(), 'Documents/personal/vault/principles/models')
const RULES: Record<string, string> = { deepseek: 'deepseek.md' }
const SECTION = 'model_rules'

export default function modelRules(pi: ExtensionAPI) {
  pi.on('before_agent_start', (event, ctx) => {
    const options = event.systemPromptOptions
    const sections = (options.sections ??= {})
    const id = ctx.model?.id.toLowerCase() ?? ''
    const file = Object.entries(RULES).find(([fragment]) => id.includes(fragment))?.[1]

    // Read on every run so vault edits apply, and drop the section after a switch to another model.
    try {
      if (!file) {
        throw new Error('no rules for this model')
      }
      sections[SECTION] = readFileSync(join(RULES_DIR, file), 'utf8')
    } catch {
      delete sections[SECTION]
    }
  })
}
