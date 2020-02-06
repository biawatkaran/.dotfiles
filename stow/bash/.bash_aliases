alias aliases='cat ~/.bash_aliases; echo "───── local ─────";cat ~/.local/.bash_aliases'
alias b='bloop'
alias buffer='subl $BYOBU_RUN_DIR/printscreen'
alias c='code .'
alias config='cd ~/.dotfiles'
alias dg='bloop projects --dot-graph | dot -Tpdf -o dependency-graph.pdf && xdg-open dependency-graph.pdf'
alias di='touch .envrc .env && direnv allow'
alias gcan!='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit -v -a --no-edit --amend'
alias gcangpf!='gcan! && gpf!'
alias gi='git init && git add . && git commit -am "Initial commit"'
alias gpe='gp && exit'
alias gwipe='gwip && exit'
alias gwipgp='gwip && gp'
alias gwipgpe='gwip && gpe'
alias hk='ga . && gcam housekeeping && gpe'
alias ipp='curl https://ipecho.net/plain; echo'
alias new-install-repo='sbtnoss new git@github.com:agilesteel/install-seed.g8.git'
alias sbtd='sbt -jvm-debug 5005'
alias sbtnoss='sbt --supershell=false'
