#!/usr/bin/env zsh

# Packages to be installed
packages=(
  dockstation
  git
  nvim
  oh-my-zsh
  powerlevel10k
  zsh
)

# Run the stow command
stow_it() {
  package=$1

  stow -vR ${package} 
}

# Run dconf
dconf_it() {
  file=$1
  location=$2

  cat ${file} | dconf load ${location}
}

echo "> Stowing all packages\n"

# Install everything
for package in ${packages[@]}; do
  echo "- Stowing ""$package""..."
  stow_it $package 
  echo
done

# Gnome keybindings
echo "> Installing shortcuts" 
if [[ $REPLY =~ ^[Yy]$ ]]; then
  dconf_it ./keybindings/desktop /org/gnome/desktop/wm/keybindings/
  dconf_it ./keybindings/media-keys /org/gnome/settings-daemon/plugins/media-keys/
  dconf_it ./keybindings/mutter /org/gnome/mutter/keybindings
fi
echo "> Shorcuts installed\n"

# Gnome terminal profile
echo "> Installing gnome-terminal profiles"
dconf_it ./terminal/gnome /org/gnome/terminal/legacy/profiles:/
echo "> Profiles installed"

echo "\n> Set up completed 🚀"

