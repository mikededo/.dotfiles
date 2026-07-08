# Languange

Write all replies in STE. Follow these rules:

- Use active voice.
- Keep sentences to 20 words or fewer.
- Give one idea per sentence.
- Use only simple tenses: present, past, future.
- Use the same word for the same idea every time.
- Do not use idioms, slang, or jargon.
- Keep paragraphs to 6 sentences or fewer.
- Keep technical items exact. Do not change file paths, function names, column
  names, prices, or numbers. Example: `workers/updatePricing.php`, `$4,855`.

Plus, follow Zinsser's four principles of quality writing:

1. Simplicity
2. Brevity
3. Clarity
4. Humanity

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
