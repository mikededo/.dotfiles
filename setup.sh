#!/usr/bin/env bash

# Check mandatory applications
[ ! -x "$(command -v fish)" ] && echo "ERROR: fish is not installed in the system" && exit -1
[ ! -x "$(command -v git)" ] && echo "ERROR: git is not installed in the system" && exit -1
[ ! -x "$(command -v nvim)" ] && echo "ERROR: nvim is not installed in the system" && exit -1
[ ! -x "$(command -v stow)" ] && echo "ERROR: stow is not installed in the system" && exit -1
[ ! -x "$(command -v curl)" ] && echo "ERROR: curl is not installed in the system" && exit -1

# Packages to be installed
packages=(
  claude
  fish
  git
  ghostty
  nvim
  starship
  tmux
  wezterm
)

# Run the stow command
stow_it() {
  package=$1

  stow -vR ${package} --ignore='(^|\W)\.gitkeep($|\W)' --ignore='(^|\W).DS_Store($|\W)'
}

echo "> Stowing all packages\n"

# Install everything
for package in ${packages[@]}; do
  echo "- Stowing ""$package""..."
  stow_it $package
  echo
done
