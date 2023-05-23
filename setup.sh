#!/usr/bin/env zsh

# Check mandatory applications
[ ! -x "$(command -v zsh)" ] && echo "ERROR: zsh is not installed in the system" && exit -1
[ ! -x "$(command -v fish)" ] && echo "ERROR: fish is not installed in the system" && exit -1
[ ! -x "$(command -v git)" ] && echo "ERROR: git is not installed in the system" && exit -1
[ ! -x "$(command -v nvim)" ] && echo "ERROR: nvim is not installed in the system" && exit -1
[ ! -x "$(command -v stow)" ] && echo "ERROR: stow is not installed in the system" && exit -1
[ ! -x "$(command -v curl)" ] && echo "ERROR: curl is not installed in the system" && exit -1

# Packages to be installed
packages=(
  git
  kitty
  nvim
  zsh
  fish
  starship
)

# Run the stow command
stow_it() {
  package=$1

  stow -vR ${package} --ignore='(^|\W)\.gitkeep($|\W)' --ignore='(^|\W).DS_Store($|\W)'
}

# git clone helper
git_clone() {
  git clone "https://github.com/$1" $2
}

echo "> Adding NvChad\n"

[ ! -d $HOME/.config/nvim ] && git_clone NvChad/NvChad $HOME/.config/nvim --depth 1

echo "> Stowing all packages\n"

# Install everything
for package in ${packages[@]}; do
  echo "- Stowing ""$package""..."
  stow_it $package
  echo
done

# Additional dependencies
echo "> Installing additional dependencies"

# Add fisher
# Figure out why it does not work
# [ ! -f ~/.config/fish/functions/tide.zsh ] && (curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher)

echo "Installing volta"
[ ! -d $HOME/.volta ] && curl https://get.volta.sh | bash
echo "volta installed"

echo "\n> Set up completed 🚀"

