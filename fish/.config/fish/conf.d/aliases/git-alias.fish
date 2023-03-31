# File for custom git aliases

# util
alias _current_branch='git branch --show-current'
alias main='git checkout main && gl'
alias master='git checkout master && gl'
alias list-branches='git branch | xargs -I {} echo {}'
alias lb='list-branches'
alias H0='HUSKY=0' # disable husky from running prehooks

# status
alias gst="git status"
alias gstu="git status -u"
alias gsts="git status -s"
# commit
alias gcan="git commit --amend --no-edit"
# staging
alias gaa='git add --all'
# merging
alias gms='git merge --squash'
# checkout
alias gco="git checkout"
alias gcb="git checkout -b"
alias gc-="git checkout -"
# remote
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gf='git fetch'
function gpsup
  git push --set-upstream origin $(_current_branch)
end
# local
alias gl='git pull'
# cherry-pick
alias gcp="git cherry-pick"
alias gcpc="git cherry-pick --continue"
alias gcpa="git cherry-pick --abort"
alias gcps="git cherry-pick --skip"

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
alias ci="_semm_commit ci"
