---
name: jj-cleanup
description: Clean up a cluttered jj repo. It fetches trunk, removes merged or deleted bookmarks, abandons stale revisions, removes finished workspaces, and rebases the remaining workspaces so none is stale. Use when the user says the jj repo is messy, has too many workspaces or bookmarks, or wants to "clean up jj", prune branches, or reset onto a fresh main/master, even if they don't name every step.
---

# jj cleanup

The work is mechanical and fully specified, so hand it to a fast agent.

## Pick the model

Call `orchestrator_capabilities` and use the `pi` provider:

1. DeepSeek V4.1 Flash, if `pi` lists it.
2. Otherwise `anthropic/claude-haiku-5-5` with `thinking: "low"`. Use `"medium"` for more than ~5 workspaces or a tangled history.

Call `delegate_task` with `mode: "wait"` and `isolation: "shared"`, because the agent must act on the real repo. Pass the brief below with the repo path filled in. If there is no delegation tool, follow the brief yourself.

The lead delegates this and reviews the child's report against command output. The lead does not run the cleanup. `jj git fetch` is the user's `jjgf`: it drops `@origin` bookmarks for branches deleted on the remote. Never `jj bookmark delete`.

## Brief

> Clean up the jj repo at `<path>`. Undo is possible through `jj op restore`, but never remove a workspace or abandon a revision whose work is not merged into trunk. Pushed is not merged: a closed or open PR still counts as unmerged.
>
> 1. Record a restore point: `jj op log -n1 --no-graph -T 'id.short()'`. Also record `jj bookmark list --all-remotes` so you can compare with origin after the fetch.
> 2. Run `jj git fetch`. Trunk is `trunk()` (main or master).
> 3. Workspaces: `jj workspace list -T 'name ++ " " ++ root ++ "\n"'`. For each one other than the default:
>    - If its directory is gone, run `jj workspace forget <name>`.
>    - If `<name>@` is empty and its work is merged (`<name>@-` is in `::trunk()`, or its bookmark's PR shows as merged in `gh pr list --head <bookmark> --state merged`), run `jj workspace remove <name>`.
>    - Keep the rest.
> 4. Bookmarks: run `jj bookmark forget` only on bookmarks that are finished:
>    - merged into trunk (`bookmarks() & ::trunk()`), or
>    - on origin before the fetch, gone from origin now, and its PR shows as merged in `gh pr list --head <bookmark> --state merged` (squash merges leave the commits outside `::trunk()`).
>
>    Keep trunk's bookmark, every unmerged bookmark (open PR, closed-but-unmerged PR, or no PR), and every local-only bookmark. A closed-but-unmerged bookmark is removed only when the user's message names it and says to remove it. Use `forget`, not `delete`. `delete` would push deletions of remote branches. Do not forget a remote bookmark that `jj git fetch` left in place.
> 5. Revisions: the candidates are `mutable() ~ ::(working_copies() | bookmarks())`, so kept bookmarks protect their commits.
>    - Abandon a candidate if it is empty, or if a bookmark forgotten in step 4 pointed at it or at a descendant (its PR was merged).
>    - Keep everything else, including closed-but-unmerged PRs and work that was never on origin, and list it as "unmerged work kept".
> 6. For each remaining workspace, including the default:
>    - Run `jj rebase -s 'roots(trunk()..<name>@)' -d 'trunk()'`. If the rebase creates conflicts, run `jj undo` and report it.
>    - Then run `jj -R <root> workspace update-stale`.
> 7. Check: `jj -R <root> status` shows no stale warning in any workspace.
>
> Report the restore op id, removed workspaces, forgotten bookmarks, abandoned revisions, kept unmerged work, any conflicts, and the final `jj workspace list`, `jj bookmark list` and `jj log`. Cite command output for each claim.
