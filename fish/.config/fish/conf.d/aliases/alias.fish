# general
alias sudo="sudo" # Make sudo not skip alias
alias vim="nvim" # Open nvim over vim
alias n="nvim" # Open nvim over vim
alias home="cd $HOME"
alias :q="exit"

# folders
alias docs="cd ~/Documents"
alias dwn="cd ~/Downloads"
alias projects="cd ~/Documents/personal/projects"

# dinamically create aliases based on the folders
for folder in (ls -d ~/Documents/personal/projects/*/ | xargs -n1 basename)
  if test $folder != 'test'
    alias $folder="projects && cd $folder"
  end
end
# extra aliases
alias stack="projects && cd stack"
alias epst="projects && cd eslint-plugin-svelte-tailwindcss"
alias sqci="projects && cd squared-ci"

# file manipulation
alias rmd="rm -rf" # Lazy remove files
alias rmds="find . -name .DS_Store | xargs rm"

# avoids having to keep entering the passphrase to sign the commits
alias reset_gpg="echo 'pinentry-program /opt/homebrew/bin/pinentry-mac' > ~/.gnupg/gpg-agent.conf && killall gpg-agent"
