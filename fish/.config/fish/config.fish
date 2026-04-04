set fish_greeting # suppress welcome text

# bun
set -gx BUN_INSTALL "$HOME/.bun"
set -gx PATH $BUN_INSTALL/bin $PATH

function fish_right_prompt_loading_indicator -a last_prompt
    echo -n "$last_prompt" | sed -r 's/\x1B\[[0-9;]*[JKmsu]//g' | read -zl uncolored_last_prompt
    echo -n (set_color brblack)"$uncolored_last_prompt"(set_color normal)
end

if command -v git town >/dev/null
    git town completions fish | source
end

if not set -q VSCODE_INJECTION; and test "$TERM_PROGRAM" != vscode
    if status is-interactive; and not set -q TMUX
        tmux attach -t default || tmux new -s default
    end
end
if command -v starship >/dev/null
    starship init fish | source
end
if command -v zoxide >/dev/null
    zoxide init fish | source
end
if command -v fnm >/dev/null
    fnm env --use-on-cd --shell fish --log-level quiet | source
end

# jj
abbr -a jjc 'jj commit -m'
abbr -a jjd 'jj desc -m'
abbr -a jjl 'jj log -r @'
abbr -a jjs 'jj show -s'
abbr -a jjn 'jj new'
abbr -a jjna 'jj new -A @-'
abbr -a jje 'jj edit'
abbr -a jja 'jj abandon'
abbr -a jjr 'jj rebase'
abbr -a jjsp 'jj split'
abbr -a jjsq 'jj squash'
abbr -a jjbm 'jj bookmark move'
abbr -a jjbs 'jj bookmark set'
abbr -a jjbc 'jj bookmark create'
abbr -a jjbt 'jj bookmark track'
abbr -a jjgp 'jj git push -b'
abbr -a jjgc 'jj git clone --colocate'
abbr -a jjfs 'jj file show -r'

fish_config theme choose custom
