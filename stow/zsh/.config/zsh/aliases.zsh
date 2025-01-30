#!/bin/sh
alias j='z'
alias f='zi'
alias g='lazygit'

alias nman='bob'
alias gm='sudo apt update && sudo apt -y full-upgrade && sudo apt -y autoremove'

# alias v="vim"
# alias lvim="env TERM=wezterm lvim"
# alias nvimrc='nvim ~/.config/nvim/'
# alias nvim="env TERM=wezterm nvim"

alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"


# Remarkable
alias remarkable_ssh='ssh root@10.11.99.1'
alias restream='restream -p'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# daily used ones
alias lst='eza --long --all --no-permissions --no-filesize --no-user --sort modified'
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
alias cat='bat --paging never --theme DarkNeon --style plain'
alias check="fzf --preview 'bat --style numbers --color always {}\'"

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory and cpu
alias psmem='ps auxf | sort -nr -k 4 | head -5'
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# systemd
alias mach_list_systemctl="systemctl list-unit-files --state=enabled"
alias mach_java_mode="export SDKMAN_DIR="$HOME/.sdkman" && [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh""

# custom shortcuts
alias tf=terraform
alias kc=kubectl
alias kns=kubens
alias kctx=kubectx
alias po='kc get pods -o wide'
alias all='kc get all'
alias svc='kc get svc'
alias ws='cd /Users/mktxmac-kbiawat/Developer/workspaces'
alias sl='/Users/mktxmac-kbiawat/Developer/Shitloads'

# Nix
alias din='echo "use nix" > .envrc && echo "watch_file nix/*" >> .envrc && di'
alias nfu='nix flake update'
alias nix-shell-q='echo -e ${buildInputs// /\\n} | cut -d - -f 2- | sort' # like nix-env -q
alias nix-shell-qq='echo -e ${buildInputs// /\\n} | sort -t- -k2,2 -k3,3' # like nix-env -q

# Nix Home Manager
alias hm='home-manager'
alias dot='/Users/mktxmac-kbiawat/Developer/.dotfiles'
alias hmd='cd /Users/mktxmac-kbiawat/Developer/.dotfiles/nix/home-manager'
alias stwd='cd /Users/mktxmac-kbiawat/Developer/.dotfiles/stow'
alias hme='vi /Users/mktxmac-kbiawat/Developer/.dotfiles/nix/home-manager/home.nix'
alias hmp='home-manager packages'
alias hmgd='home-manager generations | head -n 2 | tail -r | cut -d " " -f 7 | xargs nix store diff-closures'

#home-manager switch --flake .#mktxmac-kbiawat, when you already in that directory
alias hms='home-manager switch --flake /Users/mktxmac-kbiawat/Developer/.dotfiles/nix/home-manager#mktxmac-kbiawat && hmgd'

#alias hmu='nix flake update --flake /Users/mktxmac-kbiawat/Developer/.dotfiles/nix/home-manager#mktxmac-kbiawat && hms'
alias hmu='hmd && nfu && hms' # use hmd first as above did not work for some reason

case "$(uname -s)" in

Darwin)
#	 echo 'Mac OS X'
#	alias ls='ls -G'
	alias ls='eza --long --all --sort modified'
	;;

Linux)
#	alias ls='ls --color=auto'
	;;

CYGWIN* | MINGW32* | MSYS* | MINGW*)
	# echo 'MS Windows'
	;;
*)
	# echo 'Other OS'
	;;
esac
