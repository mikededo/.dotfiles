# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# #
# THEME
# #
# Powerlevel10k
export ZSH="$HOME/.config/zsh/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
# Powerlevel10k Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable colors
autoload -U colors && colors

# #
# PLUGINS
# #
plugins=(
	git
    docker
    docker-compose
	zsh-syntax-highlighting
	zsh-autosuggestions
    zsh-better-npm-completion
)

# #
# HISTORY
# #
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# #
# COMPLETION
# #
autoload -U compinit && compinit -u
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
setopt correct						# Command spelling
setopt complete_in_word		# Completion from within a word/phrase
setopt completealiases		# Aliases completion
setopt list_ambiguous			# Complete until it gets ambiguous

# #
# OTHER
# #
# In Arch based distros, it is needed to open new tabs in same folder
[ -f "/etc/arch-release" ] && source /etc/profile.d/vte.sh

# Preferred editor for local and remote sessions
export EDITOR='nvim'
# Custom folder
ZSH_CUSTOM=$HOME/.config/zsh/.oh-my-zsh/custom

export TERM=xterm-256color

# .dotfiles folder
export DOT=$HOME/.dotfiles

# GoLang
export GOPATH=$HOME/go

# Path
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.config/zsh/.p10k.zsh ]] || source $HOME/.config/zsh/.p10k.zsh

# NVIM fuzzy file finder plugin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# NVM - NodeJS version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
