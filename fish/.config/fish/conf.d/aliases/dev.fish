# aliases related with development, mostly  
alias check-deps="bunx npm-check-updates"
alias bi="bun install"
alias ba="bun add"
alias bad="bun add --dev"

# package.json
alias pkgscripts="jq .scripts package.json"
alias pkgdeps="jq .dependencies package.json"
alias pkgdevdeps="jq .devDependencies package.json"
alias pkgpeer="jq .peerDependencies package.json"
alias pkgalldeps="jq '{ dependencies, devDependencies, peerDependencies }' package.json"
