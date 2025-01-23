set fish_greeting # suppress welcome text

# load starship
starship init fish | source

# load volta
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

source /Users/miquel.dedomingo/.docker/init-fish.sh || true # Added by Docker Desktop
