function brew() {
  if [[ $1 == "add" ]]; then
    # Remove the first argument ("add")
    shift
    # Install the package
    command brew install "$@"
    # Update the global Brewfile
    command brew bundle dump --global --force
  else
    # Call the original brew command with all original arguments
    command brew "$@"
  fi
}

# Refresh completions
function refresh-completions() {
  local DIR=$HOME/.local/share/zsh/completions

  # bloop
  curl -s https://raw.githubusercontent.com/scalacenter/bloop/master/etc/zsh-completions -o $DIR/_bloop

  # cs
  # cs --completions zsh > $DIR/_cs
  # cs --completions zsh > $DIR/_coursier

  # sed -i 's/#compdef cs/#compdef coursier/' $DIR/_coursier

  # gh
  gh completion -s zsh > $DIR/_gh

  # scalafix
  # scalafix --zsh > $DIR/_scalafix

  # scalafmt
  curl -s https://raw.githubusercontent.com/scalameta/scalafmt/master/bin/_scalafmt -o $DIR/_scalafmt
}

# stow (th stands for target=home)
function stowth() {
  stow -vSt ~ $1
}

function unstowth() {
  stow -vDt ~ $1
}

function diy-install() {
  wget -q https://script.install.devinsideyou.com/$1
  sudo chmod +x $1 && ./$1 $2 $3
}

#function up_widget() {
#  BUFFER="cd .."
#  zle accept-line
#}

#zle -N up_widget
#bindkey "^\\" up_widget

function which-gc() {
  jcmd $1 VM.info | grep -ohE "[^\s^,]+\sgc"
}

function docker-armageddon() {
  docker stop $(docker ps -aq) # stop containers
  docker rm $(docker ps -aq) # rm containers
  docker network prune -f # rm networks
  docker rmi -f $(docker images --filter dangling=true -qa) # rm dangling images
  docker volume rm $(docker volume ls --filter dangling=true -q) # rm volumes
  docker rmi -f $(docker images -qa) # rm all images
}

function powerline_precmd() {
#  PS1="$($GOPATH/bin/powerline-go -error $? -shell zsh)"
   PS1="$($GOPATH/bin/powerline-go -error $? -shell zsh --shorten-eks-names -newline -mode compatible -modules cwd,perms,venv,aws,git,kube,docker,exit,root)"
#  PS1="$($GOPATH/bin/powerline-go -error $? -shell zsh --shorten-eks-names -newline -mode compatible -modules cwd,perms,venv,aws,kube,docker,exit,root)"
}

function install_powerline_precmd() {
   for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
        return
    fi
   done
   precmd_functions+=(powerline_precmd)
}


function docker-nerd-setup() {

  sudo apt install containerd

  archType="amd64"
  NERDCTL_VERSION="1.7.6"
  LOCAL_NERDCTL_PATH=~/.local/bin/nerdctl

  #Nerdctl did not work with nix so skipping tha below method for now, at the end building images failing with runc not on path even though it is
  if false; then
      # ensure nerdctl and cni are installed
      LOCAL_NERDCTL_VERSION=$($NERDCTL_PATH --version 2>/dev/null)
      NIX_NERDCTL_VERSION=$(echo $(nerdctl --version) | grep -o -E '[0-9]+\.[0-9]+\.[0-9]+')

      if [ ! -f $LOCAL_NERDCTL_PATH ] || [ $(nerdctl --version) != $LOCAL_NERDCTL_VERSION ]; then
        NERDCTL_VERSION=$NIX_NERDCTL_VERSION
      fi
  fi

  wget "https://github.com/containerd/nerdctl/releases/download/v${NERDCTL_VERSION}/nerdctl-full-${NERDCTL_VERSION}-linux-${archType}.tar.gz" -O /tmp/nerdctl.tar.gz
  mkdir -p ~/.local/bin
  tar -C ~/.local/bin/ -xzf /tmp/nerdctl.tar.gz --strip-components 1 bin/nerdctl
  tar -C ~/.local -xzf /tmp/nerdctl.tar.gz libexec
  tar -C ~/.local/bin/ -xzf /tmp/nerdctl.tar.gz --strip-components 1 bin/buildkitd bin/buildctl

  #cp -f $(readlink $(whereis nerdctl)) $NERDCTL_PATH

  sudo chown root $LOCAL_NERDCTL_PATH
  sudo chmod +s $LOCAL_NERDCTL_PATH
  export CNI_PATH=~/.local/libexec/cni
  #some programs are specifically looking for a binary called "docker" in the $PATH so no need to alias
  ln -s $LOCAL_NERDCTL_PATH ~/.local/bin/docker
}

funcation docker-nerd-start() {
#  sudo echo -n ; sudo "$(which containerd)" & #already running since we installed as part of docker-setup as ubuntu service
  sudo chgrp "$(id -gn)" /run/containerd/containerd.sock
  sudo $(which buildkitd) &
}

#https://docs.docker.com/engine/install/ubuntu/
function docker-setup() {
    # remove soft link to ~/.local/bin/docker if exists , it was created by docker-nerd-setup
    if [ -L ~/.local/bin/docker ]; then
      rm ~/.local/bin/docker
    fi

    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    sudo usermod -aG docker $USER
    newgrp docker
}

function docker-remove() {
  # remove Docker
  sudo apt autoremove docker-ce docker-ce-cli containerd.io
  # remove the Docker Ubuntu repository
  sudo rm /usr/share/keyrings/docker-archive-keyring.gpg /etc/apt/sources.list.d/docker.list
}