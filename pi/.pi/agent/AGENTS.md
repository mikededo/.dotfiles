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
