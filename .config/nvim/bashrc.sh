# Make nvim takeover everything
alias nvim='~/nvim.appimage'
alias vim=nvim
alias nv=nvim
export EDITOR=~/nvim.appimage

# Make nice fzf for tmux prefix Keys
alias fzf-tmux-prefix='tmux list-keys -T prefix | grep -Po "(?<=prefix\s).*" | fzf --header="Prefixed Keys" --preview="echo {}" --border --preview-window=down:3:wrap | awk '\''{first = $1; $1=""; print $0}'\'' | sed '\''s/^ //g'\'

# fzf tools
alias fzf-hist='fc -nl | fzf'

# Add the go path
export GOPATH=$(go env GOPATH)
export PATH="$GOPATH/bin:$PATH"

# wezterm
alias wezterm=wezterm.exe
function wezterm_osc7_cwd() {
  printf "\033]7;file://%s%s\033\\" "$(hostname)" "$PWD"
}
PROMPT_COMMAND="wezterm_osc7_cwd; $PROMPT_COMMAND"

# remove stupid zone identifier files
alias rmzif='sudo find . -name "*.Identifier" -type f -delete'

# copy last command
alias clc='fc -ln -1 | clip.exe'
