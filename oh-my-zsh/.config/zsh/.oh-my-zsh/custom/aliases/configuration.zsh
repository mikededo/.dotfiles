# Configurations
alias ohmyconfig="vim $HOME/.config/zsh/.oh-my-zsh/oh-my-zsh.sh"
alias p10kconfig="vim $HOME/.config/zsh/.p10k.zsh"
alias zshconfig="vim $HOME/.config/zsh/.zshrc"
alias nvimconfig="vim $HOME/.config/nvim/init.vim"
alias vimconfig="vim $HOME/.vimrc"
alias gitconfig="vim $HOME/.gitconfig"
alias dotman="$HOME/.dotfiles"
alias updzsh="exec zsh"

# Alias files
alias cfgalias="vim $HOME/.config/zsh/.oh-my-zsh/custom/aliases/configuration.zsh"
alias npmalias="vim $HOME/.config/zsh/.oh-my-zsh/custom/aliases/npm.zsh"

# snap
alias ssi="sudo snap install"
alias ssun="sudo snap remove --purge"

# yay
alias updsys="yay -Syyu"

# File manipulation
mkcd() { mkdir $1 && cd $1 }
alias rmd="rm -rf"                  # Lazy remove files
lazymv() { mv $1 $(dirname $1)$2 }  # Lazy move files

# Other 
alias sudo="sudo"                   # Make sudo not skip alias
alias vim="nvim"                    # Open nvim over vim
alias svim="sudo -E vim"            # Same but sudo
alias falias="alias | grep "        # Search for an alias
alias imgrn="exiftool -fileOrder DateTimeOriginal -recurse -extension jpg -extension jpeg -extension mp4 -ignoreMinorErrors '-FileName<FileModifyDate' -d '%Y-%m-%d-%%.3nc.%%e'"

