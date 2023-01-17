# Fast access to common directories
alias jf="$HOME/Documents/work/jobs-frontend"

# git
wclone() {
  repo="git@source.xing.com:$1.git"
  shift
  git clone $repo $@ 
}

# yarn
yyarn() { yarn && yarn $1 }

# gh cli commands
alias prcreate='gh pr create --fill --base master --assign @me --draft --label WIP --label JSR'
alias prcode_review='gh pr edit --add-label "code review" --remove-label qa --remove-label ready'
alias prqa='gh pr edit --add-label qa --remove-label "code review"'
alias prbqa='gh pr edit --add-label qa --remove-label ready'
alias prready='gh pr edit --add-label ready --remove-label qa'
acceptance() { gh pr comment $1 --body '[run-acceptance-tests]' }
qaimage() { gh pr comment $1 --body '[build-qa-docker-image]' }
imgaccept() { 
  echo -e "[run-acceptance-tests]\n[build-qa-docker-image]" > prmsg
  export prmsg=$(cat prmsg); gh pr comment $1 --body "${prmsg}"
  rm prmsg
}
