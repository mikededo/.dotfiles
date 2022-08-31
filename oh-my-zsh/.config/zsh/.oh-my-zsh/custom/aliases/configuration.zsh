# Configurations
alias ohmyconfig="vim $HOME/.config/zsh/.oh-my-zsh/oh-my-zsh.sh"
alias p10kconfig="vim $HOME/.config/zsh/.p10k.zsh"
alias zshconfig="vim $HOME/.config/zsh/.zshrc"
alias chadrc="vim $HOME/.config/nvim/lua/custom/chadrc.lua"
alias gitconfig="vim $HOME/.gitconfig"
alias kittyconfig="vim $HOME/.config/kitty/kitty.conf"
alias dotman="$HOME/.dotfiles"
alias nvimdir="$HOME/.dotfiles/nvim/.config/nvim/lua/custom"
alias updzsh="exec zsh"

# Alias files
ALIAS_DIR="$HOME/.config/zsh/.oh-my-zsh/custom/aliases"
alias cfgalias="vim $ALIAS_DIR/configuration.zsh"
alias utilalias="vim $ALIAS_DIR/utils.zsh"
alias workalias="vim $ALIAS_DIR/work.zsh"

# File manipulation
mkcd() { mkdir $1 && cd $1 }
alias rmd="rm -rf"                  # Lazy remove files

# Other
alias sudo="sudo"                   # Make sudo not skip alias
alias vim="nvim"                    # Open nvim over vim
alias svim="sudo -E vim"            # Same but sudo
alias falias="alias | grep "        # Search for an alias
alias home="$HOME"
alias t="tree"
alias :q="exit"

