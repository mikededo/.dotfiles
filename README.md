<p align="center">
  <img width="200" src="assets/Logo.png" alt="Logo">
</p>

<h1 align="center">~/.dotfiles</h1>

Personal dotfiles to keep the important configurations whenever I change the
OS. Currently, using MacOs devices, therefore the `main` branch contains the
configurations for such devices.

> Note that the other branches may not be as maintained nor up to date as the
> `main` branch.

## Set up

You can run the `./setup.sh` script which will initialise the OS by adding the
moving the packages. It uses `stow`, therefore make sure it is installed. It
requires other packages, such as `git`, `nvim` and `curl`. In case one of
the dependencies it is not found, the execution will stop.  
It installs `nvm` as a `node` and `npm` version manager, but it can easily be
removed by removing the `$HOME/.nvm` folder.

> As soon as possible, the script will be migrated to a `lua` script in order to
> provide a more customizable installation.

## fish

As well as installing `fish`, the `./setup.sh` script will also install the
[`fisher`](https://git.io/fisher) plugin manager. With it, I recommend
installing the following plugins:

> Completions can be installed from most executables (`gh`, `cargo`, `volta`...)
> and should be stored in `~/.config/fish/completions/<exec-name>.fish`.  
> Docker does not provide a `completion(s)` command. Use the following command
> to run:

```sh
curl -sS https://raw.githubusercontent.com/docker/cli/master/contrib/completion/fish/docker.fish \
  > .config/fish/completions/docker.fish
```

## Starship

Using `starship`, I have a shared prompt configuration. Since it is exclusively
for the prompt, it does not include any sort of plugin configuration.

> Configuration can be found in `./starship/.config/starship.toml`.

## Neovim

Neovim is configured using the `LazyVim` starter with some customizations.
