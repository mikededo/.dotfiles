<p align="center">
  <img width="200" src="assets/Logo.png" alt="Logo">
</p>

<h1 align="center">~/.dotfiles</h1>

Personal dotfiles to keep the important configurations whenever I change the
OS. Currently using macOs devices, therefore the `main` branch contains the
configurations for such devices. Alternatively, you can find:

- `linux` configuration in the `linux` branch (should work for all distros).

> Note that the other branches may not be as maintained nor up to date as the
> `main` branch.

## Set up

You can run the `./setup.sh` script which will initialise the OS by adding the
moving the pacakges. It uses `stow`, therefore make sure it is installed. It
requires other packages, such as `zsh`, `git`, `nvim` and `curl`. In case one of
the dependencies it is not found, the execution will stop.  
It installs `nvm` as a `node` and `npm` version manager, but it can easily be
removed by removing the `$HOME/.nvm` folder.

> As soon as possible, the script will be migrated to a `lua` script in order to
provide a more customizable installation.

## zsh && kitty

I currently use `zsh` and I do not intend to change it, as it is fast an very
customizable. In top of `zsh`, there's `powerlevel10k` for theming, with a
custom theme; and `oh-my-zsh` for added plugins and configurations.

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

> You can modify the theme by change `powerlevel10k`
[configuration](./powerlevel10k/.config/zsh/.p10k.zsh)

## Neovim

The Neovim configuration is built upon
[`NvChad`](https://github.com/NvChad/NvChad). It adds a couple of plugins to
deal with formmating and the required configurations for the LSP server.

> You can find and modify LSP configurations in the 
> [NvChad custom config folder](./nvim/.config/nvim/lua/custom/plugins).

Currently, the LSP is set up for:

- Docker
- Go
- Rust
- Typescript
- Yaml, JSON

It includes diagnostics as well as formatting for each LSP. All required LSP are
installed through the Mason plugin, meaning they will all be installed on
lauching `PackerSync`. Same happens for TreeSitter language highlightings.

> You can modify the formatting options in the 
> [`formatter.lua`](./nvim/.config/nvim/lua/custom/plugins/user/formatter.lua).

Currently using a minimally modified [NvChad](https://github.com/NvChad/NvChad)
set up. The goal is to add the plugins required in order to make it fully
functional both for front and back end development.
