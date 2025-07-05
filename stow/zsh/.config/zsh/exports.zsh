#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=10000
SAVEHIST=10000
# history
HISTFILE=~/.zsh_history

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

if [ $(command -v nvim) ]; then
  export EDITOR=$(which nvim)
  alias vim=$EDITOR
  alias v=$EDITOR
fi
#export SUDO_EDITOR=$EDITOR
#export VISUAL=$EDITOR
#export TERMINAL="kitty"
#export BROWSER="wslview"
#export BROWSER="/c/Program\ Files/Google/Chrome/Application/chrome.exe"
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

#####################################################################
#                       Docker/Colima                               #
#####################################################################
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"

#####################################################################
#                             Earthly                               #
#####################################################################
# Earthly can ONLY authenticate with Bitbucket through ssh keys added to a running ssh agent
export EARTHLY_BUILDKIT_IMAGE=mktxv-docker-prod-virtual.artifacts.tools.marketaxess.com/earthly/buildkitd:v0.8.15
export EARTHLY_SECRET_FILES=netrc="$HOME/.netrc"
export EARTHLY_DISABLE_REMOTE_REGISTRY_PROXY=true
export EARTHLY_SECRETS="ARTIFACTORY_USR,ARTIFACTORY_PSW"
#export EARTHLY_SECRETS=BITBUCKET_USR,BITBUCKET_PSW,ARTIFACTORY_USR,ARTIFACTORY_USER,ARTIFACTORY_PSW,ARTIFACTORY_PASS,TF_VAR_artifactory_user,TF_VAR_artifactory_pass,TF_VAR_master_key,AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY,AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID,AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN,SONAR_TOKEN,ARTIFACTORY_TOKEN,PRISMA_USR,PRISMA_PSW,TWS_PASSWORD,ANSIBLE_VAULT,SKYHOOK_S3_DEV_ACCESS_KEY,SKYHOOK_S3_DEV_SECRET_KEY
#export EARTHLY_SECRETS=ARTIFACTORY_USR,ARTIFACTORY_USER,ARTIFACTORY_PSW,ARTIFACTORY_PASS
# add the following to your bashrc (is one way to accomplish this)
# SSH agent

#ssh_pid_file="$HOME/.config/ssh-agent.pid"
#SSH_AUTH_SOCK="$HOME/.config/ssh-agent.sock"
#if [ -z "$SSH_AGENT_PID" ]
#then
#        # no PID exported, try to get it from pidfile
#        SSH_AGENT_PID=$(cat "$ssh_pid_file")
#fi
#
#if ! kill -0 $SSH_AGENT_PID &> /dev/null
#then
#        # the agent is not running, start it
#        rm "$SSH_AUTH_SOCK" &> /dev/null
#        >&2 echo "Starting SSH agent, since it's not running; this can take a moment"
#        eval "$(ssh-agent -s -a "$SSH_AUTH_SOCK")"
#        echo "$SSH_AGENT_PID" > "$ssh_pid_file"
#        ssh-add 2>/dev/null
#
#        >&2 echo "Started ssh-agent with '$SSH_AUTH_SOCK'"
## else
##       >&2 echo "ssh-agent on '$SSH_AUTH_SOCK' ($SSH_AGENT_PID)"
#fi
#export SSH_AGENT_PID
#export SSH_AUTH_SOCK

#earthly bootstrap #uncomment once you have earthly installed
#####################################################################

# GIT
export GIT_PS1_SHOWDIRTYSTATE=0
export GIT_PS1_SHOWSTASHSTATE=0

# MANPAGER
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

export LANG="C.UTF-8"

#####################################################################
#                             Certs                                 #
#        Commented out as using in local machine                    #
#####################################################################
# #export CERT_FILE=/etc/ssl/certs/ca-certificates.crt #windows wsl
# export CERT_FILE=/etc/nix/ca_cert.pem #mac&Nix working
# #export CERT_FILE=/etc/nix/ca_cert.crt #mac&Nix did not work
# #export CERT_FILE=/etc/nix/ca-certificates.crt #mac&Nix need to get this file via

# ## AWS
# #export AWS_PROFILE=default
# #export AWS_REGION=us-east-1
# #export AWS_CA_BUNDLE=$CERT_FILE
# export AWS_CA_BUNDLE=/etc/nix/ca_cert.pem

# ## OpenSSL
# #export OPENSSL_CONF=~/openssl.cnf
# export OPENSSL_CONF=/etc/ssl/openssl.cnf
# export SSL_CERT_FILE=$CERT_FILE

# ## Nix
# export NIX_SSL_CERT_FILE=$CERT_FILE

# ## Python
# export REQUESTS_CA_BUNDLE=$CERT_FILE
#####################################################################

# Python
export PIP_INDEX_URL=https://artifacts.tools.marketaxess.com/artifactory/api/pypi/mktxv-pypi-prod-virtual/simple
#export PIP_DISABLE_PIP_VERSION_CHECK=1
export PIP_ROOT_USER_ACTION=ignore

# Go
export GOPATH=/Users/ikaran/Shelf/workspaces/golang_ws
export PATH=$PATH:$GOPATH:$GOPATH/bin

# Java
if [ -e $HOME/.nix-profile/bin/java ]; then
  export JAVA_HOME="${$(readlink -e $HOME/.nix-profile/bin/java)%*/bin/java}" 2>/dev/null
  export JAVA_TOOL_OPTIONS="
  T
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

