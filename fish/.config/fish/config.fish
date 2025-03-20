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

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# Created by `pipx` on 2025-03-13 07:55:51
set PATH $PATH /Users/miquel.dedomingo/.local/bin
