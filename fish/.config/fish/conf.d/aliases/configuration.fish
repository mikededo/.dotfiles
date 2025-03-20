# Configurations
alias fishconfig="vim $HOME/.config/fish/config.fish"
alias starshipconfig="vim $HOME/.config/starship.toml"
alias gitconfig="vim $HOME/.gitconfig"
alias kittyconfig="vim $HOME/.config/kitty/kitty.conf"
alias dotman="cd $HOME/.dotfiles"
alias nvimdir="cd $HOME/.dotfiles/nvim/.config/nvim/"
alias updfish="exec fish"

# Alias files
set ALIAS_DIR "$HOME/.config/fish/conf.d/aliases"
alias cfgalias="vim $ALIAS_DIR/configuration.fish"
alias devalias="vim $ALIAS_DIR/dev.fish"
alias gitalias="vim $ALIAS_DIR/git-alias.fish"
alias workalias="vim $ALIAS_DIR/work.fish"
alias falias="alias | grep" # search for an alias
