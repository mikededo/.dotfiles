# general
alias sudo="sudo"                   # Make sudo not skip alias
alias vim="nvim"                    # Open nvim over vim
alias home="cd $HOME"
alias :q="exit"

# file manipulation
alias rmd="rm -rf"                  # Lazy remove files
alias rmds="find . -name .DS_Store | xargs rm"

## avoids having to keep entering the passphrase to sign the commits
alias reset_gpg="echo 'pinentry-program /opt/homebrew/bin/pinentry-mac' > ~/.gnupg/gpg-agent.conf && killall gpg-agent"
alias clear_ds="find . -name '.DS_Store' | xargs rm"
