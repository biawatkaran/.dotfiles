# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
  fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

# Homebrew
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ] ; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# set PATH so it includes coursier bin if it exists
if [ -d "$HOME/.local/share/coursier/bin" ] ; then
  PATH="$PATH:$HOME/.local/share/coursier/bin"
fi

# environment variables
export EDITOR="/usr/local/bin/nvim"
export VISUAL=$EDITOR

export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

export GRAALVM_HOME=/usr/lib/jvm/graalvm/bin
export JAVA_HOME=/usr/lib/jvm/graalvm

# set PATH so it includes GRAALVM_HOME if it exists
if [ -d "$GRAALVM_HOME" ] ; then
  PATH="$PATH:$GRAALVM_HOME"
fi

export JAVA_TOOL_OPTIONS="
-Dconfig.override_with_env_vars=true
-Duser.timezone=UTC"

# run gpg-agent
eval $(gpg-agent --daemon > /dev/null 2>&1)

# source local settings
if [ -f "$HOME/.local/.profile" ] ; then
  source "$HOME/.local/.profile"
fi
