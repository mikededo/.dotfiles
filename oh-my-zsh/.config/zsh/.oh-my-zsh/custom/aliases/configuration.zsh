# Configurations
alias ohmyconfig="vim $HOME/.config/zsh/.oh-my-zsh/oh-my-zsh.sh"
alias p10kconfig="vim $HOME/.config/zsh/.p10k.zsh"
alias zshconfig="vim $HOME/.config/zsh/.zshrc"
alias nvimconfig="vim $HOME/.config/nvim/init.vim"
alias vimconfig="vim $HOME/.vimrc"
alias gitconfig="vim $HOME/.gitconfig"
alias dotman="$HOME/Documents/dotman"
alias updzsh="exec zsh"

# Alias files
alias cfgalias="vim $HOME/.config/zsh/.oh-my-zsh/custom/aliases/configuration.zsh"
alias npmalias="vim $HOME/.config/zsh/.oh-my-zsh/custom/aliases/npm.zsh"

# apt
alias si="sudo apt install"
alias sun="sudo apt remove --purge"
alias sysupdt="sudo apt update && sudo apt upgrade"
alias aptclean="sudo apt autoclean && sudo apt autoremove"

# snap
alias ssi="sudo snap install"
alias ssun="sudo snap remove --purge"

# File manipulation
mkcd() { mkdir $1 && cd $1 }
alias rmd="rm -rf"                  # Lazy remove files
lazymv() { mv $1 $(dirname $1)$2 }  # Lazy move files

# Other 
alias sudo="sudo "                  # Make sudo not skip alias
alias vim="nvim"                    # Open nvim over vim
alias svim="sudo vim"               # Same but sudo
alias falias="alias | grep "        # Search for an alias
alias dotupdcfg="vim $HOME/Documents/dotman/update.sh"
alias mysql="mysql -u mddg"         # Open mysql and ask for password
alias imgrn="exiftool -fileOrder DateTimeOriginal -recurse -extension jpg -extension jpeg -extension mp4 -ignoreMinorErrors '-FileName<FileModifyDate' -d '%Y-%m-%d-%%.3nc.%%e'"

