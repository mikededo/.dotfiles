# dotfiles

`.dotfiles` that I use for my workflow at Xing.

## Installation

In order to install the `.dotfiles`, run the [install script](./setup.sh). It
will check for the required dependencies and it will as to install them if such
dependendcies do not exist. Such dependecies are: `zsh`, `git`, `nvim` (in brew
and any other package manager is `neovim`), `stow` and `curl`. 

## nvim

Currently using a minimally modified [NvChad](https://github.com/NvChad/NvChad)
set up. The goal is to add the plugins required in order to make it fully
functional both for front and back end development.

## zsh & kitty

`zsh` is the default shell for MacOs (in newer versions). Since a long time ago
I have been using kitty, and IMO it works better than iTerm and iTerm2. It also
allows font ligatures.  
The following plugins are used in zsh (see [the config
file](./zsh/.config/zsh/.zshrc):

- `git` for git autocompletion and other features 
- `docker` and `docker-compose` for docker utilities
- `zsh-syntax-highlighting` for highlighting the text written in the terminal
- `zsh-autosuggestion` for command suggestions

### powerlevel10k

With zsh, I also use [powerlevel10k](https://github.com/romkatv/powerlevel10k)
which is provides a lot of features, other that theming the terminal.
