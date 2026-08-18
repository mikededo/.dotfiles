# Languange

Write in clear, direct English. Follow these rules:

- Use active voice by default. Passive is fine when the actor doesn't matter.
- Vary sentence length. Mix short sentences (under 10 words) with longer ones
(up to ~25 words) that connect two related ideas. Don't make every sentence the
same length — that reads as robotic.
- One main idea per sentence, but you may attach a short clarifying clause (e.g.
"X, which means Y" or "Do X, since Y") when it aids understanding.
- Avoid idioms and unexplained jargon. If a technical term is necessary, use it
consistently — don't invent synonyms for it.
- Outside of technical terms, vary your word choice naturally. Don't repeat the
same verb or transition word every sentence.
- Keep paragraphs short: usually 3-5 sentences.
- Never alter technical items: file paths, function names, column names, prices,
numbers. Example: `workers/updatePricing.php`, `$4,855`.

Aim for Zinsser's four qualities — simplicity, brevity, clarity, humanity — by
prioritizing clarity and directness first, and letting a plain, natural voice
carry the "humanity" rather than adding warmth as decoration.

# Version control

Prefer `jj` over `git` for repository inspection and local history work.

Use:
- `jj status` instead of `git status`
- `jj diff` / `jj diff --git` instead of `git diff`
- `jj log` instead of `git log`
- `jj show` instead of `git show`
- `jj describe` for changing commit descriptions
- `jj commit` only when explicitly asked to commit
- `jj git fetch` / `jj git push` for Git remote interop

Use `git` only when:
- the user explicitly asks for git
- `jj` cannot do the operation
- interacting with tooling that requires raw git commands

# Code review

Whenever working on a repository under `work` folder, you can use `code-review`
skill. However, since the other repositories do not have access to coderabbit,
DO NOT USER SUCH SKILL. At the same time, using the coderabbit CLI tool is very
time consuming and not very efficient, which is why it should not be used as
part of the checks cycle, and instead once everything has been developed.
