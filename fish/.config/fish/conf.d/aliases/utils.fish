# git
alias master='git checkout master && gl'
alias main='git checkout main && gl'
alias list-branches='git branch | xargs -I {} echo {}'
alias lb='list-branches'
alias H0='HUSKY=0' # disable husky from running prehooks
# git commit messages
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
alias fix="_semm_commit feat"
alias refactor="_semm_commit refactor"
alias ctest="_semm_commit test"

# yarn
alias fp="yarn list | grep $1"
alias fp0="yarn list --depth 0 | grep $1"
