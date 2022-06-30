# dotfiles

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

## zsh

I currently use `zsh` and I do not intend to change it, as it is fast an very
customizable. In top of `zsh`, there's `powerlevel10k` for theming, with a
custom theme; and `oh-my-zsh` for added plugins and configurations.

> You can modify the theme by change `powerlevel10k` [configuration]
> (./powerlevel10k/.config/zsh/.p10k.zsh)

## Neovim

The Neovim configuration is built upon
[`NvChad`](https://github.com/NvChad/NvChad). It adds a couple of plugins to
deal with formmating and the required configurations for the LSP server.

> You can find and modify LSP configurations in the [NvChad custom config folder]
> (./nvim/.config/nvim/lua/custom/plugins).

Currently, the LSP is set up for:

- JavaScript/TypeScript development, including intellisense, ESLint error
display and prettier formatting.
  - In order to have the environment fully functional, make sure to globally
  install:
    - `typescript-language-server` and `diagnostics-languageserver` as the base
    packages.
    - `eslint_d` for fast ESLint linting.
    - `prettier_d` for fast code prettifying.
  - HTML and CSS are also included, but not much has been configurated.
- Golang development, using the `vim-go` plugin and `gopls` for linting and
error fixing.

> You can modify the formatting options in the [`formatter.lua`]
> (./nvim/.config/nvim/lua/custom/plugins/user/formatter.lua).


