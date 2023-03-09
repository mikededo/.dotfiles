alias t="tree"
alias m="make"

# yarn
alias fp="yarn list | grep $1"
alias fp0="yarn list --depth 0 | grep $1"
alias pkgscripts="cat package.json | jq '.scripts'"
alias pkgdeps="cat package.json | jq '.dependencies'"
alias pkgdevdeps="cat package.json | jq '.devDependencies'"

