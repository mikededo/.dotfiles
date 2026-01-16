# general
alias sudo="sudo"
abbr -a vim nvim
abbr -a n nvim
abbr -a :q exit

# file manipulation
abbr -a rmd 'rm -rf'
alias rmds="find . -name .DS_Store | xargs rm"
# avoids having to keep entering the passphrase to sign the commits
alias reset_gpg="echo 'pinentry-program /opt/homebrew/bin/pinentry-mac' > ~/.gnupg/gpg-agent.conf && killall gpg-agent"

# Configurations
alias dotman="cd $HOME/.dotfiles"
alias fishconfig="nvim $HOME/.config/fish/config.fish"
alias ghostconfig="nvim $HOME/.config/ghostty/config"
alias gitconfig="nvim $HOME/.gitconfig"
alias nvimdir="cd $HOME/.dotfiles/nvim/.config/nvim/"
alias starshipconfig="nvim $HOME/.config/starship.toml"
alias updfish="exec fish"
alias wezconfig="nvim $HOME/.config/wezterm/wezterm.lua"
alias falias="alias | grep" # search for an alias

# aliases related with development, mostly  
abbr -a v vercel
alias check-deps="bunx npm-check-updates"
abbr -a bi 'bun install'
abbr -a ba 'bun add'
abbr -a bad 'bun add --dev'
# package.json
alias pkgscripts="jq .scripts package.json"
alias pkgdeps="jq .dependencies package.json"
alias pkgdevdeps="jq .devDependencies package.json"
alias pkgpeer="jq .peerDependencies package.json"
alias pkgalldeps="jq '{ dependencies, devDependencies, peerDependencies }' package.json"

# branching
alias _current_branch='git branch --show-current'
alias def_branch="git symbolic-ref --short HEAD"
abbr -a main 'git checkout main && git pull'
abbr -a master 'git checkout master && git pull'
abbr -a dev 'git checkout dev && git pull'
alias list-branches='git branch | xargs -I {} echo {}'
alias glsb='list-branches'
abbr -a gt 'git town'

# status
abbr -a gs 'git status'
abbr -a gstu 'git status -u'
abbr -a gsts 'git status -s'
# commit
abbr -a gcan 'git commit --amend --no-edit'
abbr -a gca 'git commit --amend'
# staging
abbr -a gaa 'git add --all'
# merging
abbr -a gms 'git merge --squash'
# checkout
abbr -a gco 'git checkout'
abbr -a gcb 'git checkout -b'
abbr -a gc- 'git checkout -'
# rebase
abbr -a grem 'git rebase main'
abbr -a gremm 'git rebase master'
abbr -a grea 'git rebase --abort'
abbr -a grec 'git rebase --continue'
# remote
abbr -a gp 'git push'
abbr -a gpf 'git push --force-with-lease'
abbr -a gf 'git fetch'
abbr -a grpo 'git remote prune origin'
function gpsup
    git push --set-upstream origin $(_current_branch)
end
alias updrem='git fetch && git rebase origin/main'
alias updremm='git fetch && git rebase origin/master'
# local
abbr -a gl 'git pull'
function clear-branches
    git fetch --prune && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -I {} git branch -D {}
end
# cherry-pick
abbr -a gcp 'git cherry-pick'
abbr -a gcpc 'git cherry-pick --continue'
abbr -a gcpa 'git cherry-pick --abort'
abbr -a gcps 'git cherry-pick --skip'

# commit messages
function _semm_commit
    set prefix $argv[1]
    set -e argv[1]

    if test (count $argv) -eq 1
        git commit -m "$prefix: $argv[1]"
    else if test (count $argv) -eq 2
        git commit -m "$prefix($argv[1]): $argv[2]"
    else
        echo "Invalid number of arguments"
    end
end
alias chore="_semm_commit chore"
alias feat="_semm_commit feat"
alias fix="_semm_commit fix"
alias refactor="_semm_commit refactor"
alias docs="_semm_commit docs"
alias ctest="_semm_commit test"
alias ci="_semm_commit ci"

# other
alias check-log="git diff --staged -G console"
# new pr
alias npr="gh pr create -a @me"
# draft new pr
alias dpr="gh pr create --draft -a @me"
# new empty body pr
alias nepr="gh pr create -a @me --body ''"
# view pr in web
alias vpr="gh pr view -w"
# mark as ready
alias prr="gh pr ready"
