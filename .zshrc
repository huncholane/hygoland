# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="blinks"

plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
    fuzzy-funcs
)

source $ZSH/oh-my-zsh.sh

# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r #without fastfetch
#pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# fastfetch. Will be disabled if above colorscript was chosen to install
fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up icons for files/directories in terminal using lsd
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# neovim takeover
export EDITOR=nvim
alias vim=nvim
alias v=nvim
alias nv=nvim
alias vi=nvim

# readonly vim -> ex: ps aux | vr
alias vr="nvim -R -M"

# add go bin to path
export PATH=$PATH:$(go env GOPATH)/bin

# prevent cargo build from destroying computer
export CARGO_BUILD_JOBS=20

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/huncho/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/huncho/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/huncho/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/huncho/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/home/huncho/miniforge3/bin/mamba';
export MAMBA_ROOT_PREFIX='/home/huncho/miniforge3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# simpler ipython alias
alias py=ipython

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias tm='tmux attach || tmux'
alias src='clear && source ~/.zshrc'

alias dcu='docker compose build && docker compose down --remove-orphans && docker compose up -d && docker compose logs -f'

# Add gem to environment
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.4.0/bin"

# Add mason to environment path
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"

# Copy last command
alias copylast='fc -ln -1 | wl-copy'

# Source .env file
dot() {
  set -a
  local file="${1:-.env}"
  [ -f "$file" ] && source "$file"
  set +a
}
