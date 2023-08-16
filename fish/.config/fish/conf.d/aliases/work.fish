# Fast access to common directories
alias work="cd $HOME/Documents/work"
alias jf="cd $HOME/Documents/work/jobs-frontend"
alias crate="cd $HOME/Documents/work/crate"
alias brewery="cd $HOME/Documents/work/brewery"

# crate
alias sync-references="yarn monorepo sync-project-references"
alias sync-ref-push="sync-references && gaa && fix jobs 'run `yarn sync-project-references`' && gp"
alias gen-graphql="yarn monorepo graphql-types-generator packages/jobs/graphql"
function translations
  yarn monorepo fetch-translations $argv[1]
end
function test-components
  yarn monorepo test "xinglets/jobs/components/$argv[1]"
end
alias test-hooks="yarn monorepo test xinglets/jobs/hooks"
function test-domain
  yarn monorepo test "xinglets/jobs/domain/$argv[1]"
end

# git
function wclone
  set repo "git@source.xing.com:$argv[1].git"
  set -e argv[1]
  git clone $repo $argv
end

# yarn
function yyarn
  yarn && yarn $argv
end

# gh cli commands
alias prcreate='gh pr create --fill --base master --assignee @me --draft --label WIP --label JSR'
alias prcode_review='gh pr edit --add-label "code review" --remove-label qa --remove-label ready'
alias prqa='gh pr edit --add-label qa --remove-label "code review"'
alias prbqa='gh pr edit --add-label qa --remove-label ready'
alias prready='gh pr edit --add-label ready --remove-label qa'
## pr comments
function acceptance
  gh pr comment $argv[1] --body '[run-acceptance-tests]'
end
function qaimage
  gh pr comment $argv[1] --body '[build-qa-docker-image]'
end
function imgaccept
  printf "[run-acceptance-tests]\n[build-qa-docker-image]" > prmsg
  set prmsg (cat prmsg)
  gh pr comment $argv[1] --body "$prmsg"
  rm prmsg
end

