# File for custom git aliases

# util
alias _current_branch='git branch --show-current'
alias main='git checkout main && gl'
alias master='git checkout master && gl'
alias list-branches='git branch | xargs -I {} echo {}'
alias lb='list-branches'
alias H0='HUSKY=0' # disable husky from running prehooks

# staging
alias gaa='git add --all'
# merging
alias gms='git merge --squash'
# remote
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gf='git fetch'
function gpsup
  git push --set-upstream origin $(_current_branch)
end
# local
alias gl='git pull'

# Commit messages
function _semm_commit
  set prefix $argv[1]
  set -e argv[1]

  if test (count $argv) -eq 1
    git commit -m "$prefix: $argv[1]"
  else if test (count $argv) -eq 2
    git commit -m "$prefix($argv[1]): $argv[2]"
  else
    echo "Invalid number of arguments"
  end
end
alias chore="_semm_commit chore"
alias feat="_semm_commit feat"
alias fix="_semm_commit fix"
alias refactor="_semm_commit refactor"
alias docs="_semm_commit docs"
alias ctest="_semm_commit test"
