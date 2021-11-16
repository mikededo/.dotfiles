# npm
#	Package managing
alias nig="sudo npm install --global"
alias ni="npm install"
alias nis="npm install --save-dev"
alias nit="npm install-test"
alias nits="npm install-test --save-dev"
alias nu="npm uninstall"
alias nus="npm uninstall --save-dev"
alias nup="npm upgrade"
alias nud="npm udpate"
alias nod="npm outdated"
# Scripts
alias nr="npm run"
alias ns="npm start"
alias nrs="npm run start"
#	Packages
alias nls="npm list"
alias nlsg="npm list --global"
#	@react
alias nrrd="nis react-router-dom"
alias nrpt="nis prop-types"
#	@General
alias ibabel="nis @babel/core @babel/preset-env @babel/node"

# Package specific
#	json-server
alias genjs="mkdir -p data && echo \"{\n\n}\" >> data/db.json"
alias genjscfg="mkdir -p data && echo \"{\n\n}\" >> data/config.json"
alias jsonscfg="json-server --config data/config.json"
jsons() {
	if [ -z $1 ]; then
		json-server --watch data/db.json --port 8000
	else
		json-server --watch $1 --port 8000
	fi
}
jsonsp() {
	if [ -z $2 ]; then
		json-server --watch data/db.json --port $1
	else
		json-server --watch $1 --port $2
	fi
}
jsonctm() { json-server "$@" }

