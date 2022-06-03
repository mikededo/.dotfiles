# Fast access to common directories
alias docs="$HOME/Documents/Work"
alias jf="$HOME/Documents/jobs-frontend"

# gh cli commands
acceptance() { gh pr comment $1 --body '[run-acceptance-tests]' }
imgaccept() { 
  echo -e "[run-acceptance-tests]\n[build-qa-docker-image]" > prmsg
  export prmsg=$(cat prmsg); gh pr comment $1 --body "${prmsg}"
  rm prmsg
}
