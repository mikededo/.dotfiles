#!/bin/zsh

[ -f "$HOME/.config/env" ] && source "$HOME/.config/env"

# .zshrc file location
ZDOTDIR=$HOME/.config/zsh

# brew
eval "$(/opt/homebrew/bin/brew shellenv)"
