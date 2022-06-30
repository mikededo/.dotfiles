# Fast access to common directories
alias docs="$HOME/Documents/Work"
alias jf="$HOME/Documents/jobs-frontend"
alias master='git checkout master && gl'

# Yarn related
yyarn() { yarn && yarn $1 }

# gh cli commands
acceptance() { gh pr comment $1 --body '[run-acceptance-tests]' }
qaimage() { gh pr comment $1 --body '[build-qa-docker-image]' }
imgaccept() { 
  echo -e "[run-acceptance-tests]\n[build-qa-docker-image]" > prmsg
  export prmsg=$(cat prmsg); gh pr comment $1 --body "${prmsg}"
  rm prmsg
}
