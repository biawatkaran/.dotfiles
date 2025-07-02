#!/usr/bin/env nu
alias j = z
alias f = zi
alias g = lazygit

alias nman = bob

# Remarkable
# alias remarkable_ssh='ssh root@10.11.99.1'
# alias restream='restream -p'

# Colorize grep output (good for log files)
alias grep = grep --color=auto
alias egrep = egrep --color=auto
alias fgrep = fgrep --color=auto

# daily used ones
alias ll = ls -al
alias cat = bat --paging never --theme DarkNeon --style plain
alias check = fzf --preview 'bat --style numbers --color always {}\'

# custom shortcuts
alias tf = terraform

alias kc = kubectl
alias kns = kubens
alias kctx = kubectx
alias po = kubectl get pods -o wide
alias all = kubectl get all
alias svc = kubectl get svc
alias ws = cd /Users/mktxmac-kbiawat/Developer/workspaces
alias sl = cd /Users/mktxmac-kbiawat/Developer/Shitloads

## Nix
alias nfu = nix flake update

## Nix Home Manager
alias hm = home-manager
alias dot = cd /Users/mktxmac-kbiawat/Developer/.dotfiles
alias hmd = cd /Users/mktxmac-kbiawat/Developer/.dotfiles/nix/home-manager
alias stwd = cd /Users/mktxmac-kbiawat/Developer/.dotfiles/stow
alias hme = vi /Users/mktxmac-kbiawat/Developer/.dotfiles/nix/home-manager/home.nix
alias hmp = home-manager packages
