# general
alias sudo="sudo" # Make sudo not skip alias
alias vim="nvim" # Open nvim over vim
alias n="nvim" # Open nvim over vim
alias home="cd $HOME"
alias :q="exit"

# folders
alias docs="cd ~/Documents/"
alias dwn="cd ~/Downloads/"
alias projects="cd ~/Documents/personal/projects/"

# file manipulation
alias rmd="rm -rf" # Lazy remove files
alias rmds="find . -name .DS_Store | xargs rm"

# avoids having to keep entering the passphrase to sign the commits
alias reset_gpg="echo 'pinentry-program /opt/homebrew/bin/pinentry-mac' > ~/.gnupg/gpg-agent.conf && killall gpg-agent"
