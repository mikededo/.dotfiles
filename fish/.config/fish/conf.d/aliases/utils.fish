# yarn
alias fp="yarn list | grep $1"
alias fp0="yarn list --depth 0 | grep $1"

# other
## avoids having to keep entering the passphrase to sign the commits
alias reset_gpg="echo 'pinentry-program /opt/homebrew/bin/pinentry-mac' > ~/.gnupg/gpg-agent.conf && killall gpg-agent"
