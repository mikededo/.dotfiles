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
