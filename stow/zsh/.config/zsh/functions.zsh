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

function up_widget() {
  BUFFER="cd .."
  zle accept-line
}

zle -N up_widget
bindkey "^\\" up_widget

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
 #PS1="$($GOPATH/bin/powerline-go -error $? -shell zsh)"
 PS1="$($GOPATH/bin/powerline-go -error $? -shell zsh --shorten-eks-names -newline -mode compatible -modules cwd,perms,venv,aws,git,kube,docker,exit,root)"
}

function install_powerline_precmd() {
   for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
        return
    fi
   done
   precmd_functions+=(powerline_precmd)
}