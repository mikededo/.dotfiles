#!/bin/zsh
[ -f "$HOME/.config/env" ] && source "$HOME/.config/env"

# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Oly
export PATH="/Users/miquel.dedomingo/.oly/bin:$PATH"
export PATH="/Users/miquel.dedomingo/.gem/ruby/2.6.0/bin:$PATH"

# .zshrc file location
ZDOTDIR=$HOME/.config/zsh
