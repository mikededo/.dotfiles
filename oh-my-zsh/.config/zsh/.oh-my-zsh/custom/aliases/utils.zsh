# git
alias master='git checkout master && gl'
alias main='git checkout main && gl'

# yarn
alias fp="yarn list | grep $1"
alias fp0="yarn list --depth 0 | grep $1"

# Random
EXTENSIONS="-extension jpg -extension jpeg -extension mp4 -extension mov"
alias imgrn="exiftool -fileOrder DateTimeOriginal -recurse $EXTENSIONS -ignoreMinorErrors '-FileName<FileModifyDate' -d '%Y-%m-%d-%%.3nc.%%e'"

