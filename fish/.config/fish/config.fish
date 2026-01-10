set fish_greeting # suppress welcome text

# bun
set -gx BUN_INSTALL "$HOME/.bun"
set -gx PATH $BUN_INSTALL/bin $PATH

function fish_right_prompt_loading_indicator -a last_prompt
    echo -n "$last_prompt" | sed -r 's/\x1B\[[0-9;]*[JKmsu]//g' | read -zl uncolored_last_prompt
    echo -n (set_color brblack)"$uncolored_last_prompt"(set_color normal)
end

# lazy load python from pyenv
function python --wraps python
    pyenv init - | source
    functions -e python pip
    python $argv
end

function pip --wraps pip
    pyenv init - | source
    functions -e python pip
    pip $argv
end

# auto-start tmux 
if status is-interactive; and not set -q TMUX
    exec tmux
end

# load starship 
starship init fish | source
