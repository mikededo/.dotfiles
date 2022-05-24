# Configurations
alias ohmyconfig="vim $HOME/.config/zsh/.oh-my-zsh/oh-my-zsh.sh"
alias p10kconfig="vim $HOME/.config/zsh/.p10k.zsh"
alias zshconfig="vim $HOME/.config/zsh/.zshrc"
alias chadrc="nvim $HOME/.config/nvim/lua/custom/chadrc.lua"
alias gitconfig="vim $HOME/.gitconfig"
alias kittyconfig="vim $HOME/.config/kitty/kitty.conf"
alias dotman="$HOME/.dotfiles"
alias updzsh="exec zsh"

# Alias files
alias cfgalias="vim $HOME/.config/zsh/.oh-my-zsh/custom/aliases/configuration.zsh"
alias npmalias="vim $HOME/.config/zsh/.oh-my-zsh/custom/aliases/npm.zsh"
alias workalias="vim $HOME/.config/zsh/.oh-my-zsh/custom/aliases/work.zsh"

# File manipulation
mkcd() { mkdir $1 && cd $1 }
alias rmd="rm -rf"                  # Lazy remove files

# Other
alias sudo="sudo"                   # Make sudo not skip alias
alias vim="nvim"                    # Open nvim over vim
alias svim="sudo -E vim"            # Same but sudo
alias falias="alias | grep "        # Search for an alias
alias imgrn="exiftool -fileOrder DateTimeOriginal -recurse -extension jpg -extension jpeg -extension mp4 -ignoreMinorErrors '-FileName<FileModifyDate' -d '%Y-%m-%d-%%.3nc.%%e'"

