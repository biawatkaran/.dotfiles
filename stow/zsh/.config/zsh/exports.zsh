#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=10000
SAVEHIST=10000

if [ $(command -v nvim) ]; then
  export EDITOR=$(which nvim)
  alias vim=$EDITOR
  alias v=$EDITOR
fi
#export SUDO_EDITOR=$EDITOR
#export VISUAL=$EDITOR
#export TERMINAL="kitty"
#export BROWSER="wslview"
export BROWSER="/c/Program\ Files/Google/Chrome/Application/chrome.exe"
export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.docker/bin":$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/share/go/bin:$PATH
#export GOPATH=$HOME/.local/share/go
export PATH=$HOME/.fnm:$PATH
export PATH="$HOME/.local/share/neovim/bin":$PATH
export PATH="$HOME/.local/share/bob/nvim-bin":$PATH
export XDG_CURRENT_DESKTOP="Wayland"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
#export PATH="$PATH:./node_modules/.bin"
#eval "$(fnm env)"
#eval "$(zoxide init zsh)"
# eval "`pip completion --zsh`"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

# GIT
export GIT_PS1_SHOWDIRTYSTATE=0
export GIT_PS1_SHOWSTASHSTATE=0

# MANPAGER
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

export LANG="C.UTF-8"

export AWS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
#export AWS_REGION=us-east-1
#export AWS_PROFILE=default

#export OPENSSL_CONF=~/openssl.cnf
export OPENSSL_CONF=/etc/ssl/openssl.cnf
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
export NIX_SSL_CERT_FILE=$SSL_CERT_FILE

export GOPATH=/c/Users/KBiawat/Shelf/Workspaces/golang_ws
export PATH=$PATH:$GOPATH:$GOPATH/bin

if [ -e $HOME/.nix-profile/bin/java ]; then
  export JAVA_HOME="${$(readlink -e $HOME/.nix-profile/bin/java)%*/bin/java}" 2>/dev/null
  export JAVA_TOOL_OPTIONS="
  -Dconfig.override_with_env_vars=true
  -Djava.net.preferIPv4Stack=true
  -Duser.timezone=UTC
  "
fi

#change as above
#export DOCKER_PATH=<PLACEHOLDER>
#export GRADLE_PATH=<PLACEHOLDER

# nerdctl configs - https://guide2wsl.com/nerdctl/ UNCOMMENT ALL BELOW LINES TO USE NERDCTL
#alias nerdctl=docker alias not needed when ln -s softlink created by below lines
#in order to use docker simply comment this section and have docker installed too
# check docker-nerd method in functions file
#if [ -e $HOME/.nix-profile/bin/nerdctl ]; then
#  alias docker=nerdctl #alias not needed when ln -s softlink created by below lines
#  export CNI_PATH=~/.local/libexec/cni
#fi

# TF local Configs
export TF_LOG="DEBUG"
export TF_LOG_PATH="$HOME/terraform-debug.log"

## >>> conda initialize >>>
## !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$("$HOME/.miniconda/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "$HOME/.miniconda/etc/profile.d/conda.sh" ]; then
#        . "$HOME/.miniconda/etc/profile.d/conda.sh"
#    else
#        export PATH="$HOME/.miniconda/bin:$PATH"
#    fi
#fi
#unset __conda_setup
## <<< conda initialize <<<

