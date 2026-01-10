# Configurations
alias dotman="cd $HOME/.dotfiles"
alias fishconfig="vim $HOME/.config/fish/config.fish"
alias ghostconfig="vim $HOME/.config/ghostty/config"
alias gitconfig="vim $HOME/.gitconfig"
alias nvimdir="cd $HOME/.dotfiles/nvim/.config/nvim/"
alias starshipconfig="vim $HOME/.config/starship.toml"
alias updfish="exec fish"
alias wezconfig="vim $HOME/.config/wezterm/wezterm.lua"

# Alias files
set ALIAS_DIR "$HOME/.config/fish/conf.d/aliases"
alias cfgalias="vim $ALIAS_DIR/configuration.fish"
alias devalias="vim $ALIAS_DIR/dev.fish"
alias gitalias="vim $ALIAS_DIR/git.fish"
alias ghalias="vim $ALIAS_DIR/git.fish"
alias workalias="vim $ALIAS_DIR/work.fish"
alias falias="alias | grep" # search for an alias
