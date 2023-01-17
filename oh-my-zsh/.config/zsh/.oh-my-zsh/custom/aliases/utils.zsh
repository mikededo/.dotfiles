# git
alias master='git checkout master && gl'
alias main='git checkout main && gl'
alias list-branches='git branch | xargs -I {} echo {}'
alias lb='list-branches'
alias H0='HUSKY=0' # disable husky from running prehooks
# git commit messages
_semm_commit() {
  prefix=$1
  shift
  if [ $# -eq 1 ]; then
    git commit -m "feat: $1"
  elif [ $# -eq 2 ]; then
    git commit -m "feat($1): $2"
  else
    echo "Invalid number of arguments"
  fi
}
alias chore="_semm_commit chore"
alias feat="_semm_commit feat"
alias fix="_semm_commit feat"
alias refactor="_semm_commit refactor"

# yarn
alias fp="yarn list | grep $1"
alias fp0="yarn list --depth 0 | grep $1"
