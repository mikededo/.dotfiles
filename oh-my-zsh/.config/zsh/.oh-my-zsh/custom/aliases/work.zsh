# Fast access to common directories
alias jf="$HOME/Documents/work/jobs-frontend"

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
