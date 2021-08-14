# npm
#	Package managing
alias nig="sudo npm install --global"
alias ni="npm install"
alias nis="npm install --save"
alias nid="npm install --save-dev"
alias nxi="npx install"
alias nit="npm install-test"
alias nits="npm install-test --save"
alias nitd="npm install-test --save-dev"
alias nu="npm uninstall"
alias nus="npm uninstall --save"
alias nud="npm uninsatll --save-dev"
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
alias ibabel="nisd @babel/core @babel/preset-env @babel/node"

# Package specific
#	React
cra() {
	if [ -z $1 ]; then
		create-react-app .
	else
		create-react-app $1
	fi
}
rhoc() {
	if [ -z $1 ]; then
		mkdir -p hoc && touch hoc/Wrapper.jsx
	else
		mkdir -p hoc && touch hoc/$1.jsx
	fi
}
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

