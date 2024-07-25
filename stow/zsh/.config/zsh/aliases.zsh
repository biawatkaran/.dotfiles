#!/bin/sh
alias j='z'
alias f='zi'
alias g='lazygit'
# alias v="vim"
# alias lvim="env TERM=wezterm lvim"
# alias nvimrc='nvim ~/.config/nvim/'
# alias nvim="env TERM=wezterm nvim"
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"
alias nman='bob'
alias la='ls -altrh'
alias gm='sudo apt update && sudo apt -y full-upgrade && sudo apt -y autoremove'

# Remarkable
alias remarkable_ssh='ssh root@10.11.99.1'
alias restream='restream -p'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# systemd
alias mach_list_systemctl="systemctl list-unit-files --state=enabled"

alias mach_java_mode="export SDKMAN_DIR="$HOME/.sdkman" && [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh""

# custom aliases
alias tf=terraform
alias kc=kubectl
alias kns=kubens
alias kctx=kubectx
#alias python=python3
alias po='kc get pods -o wide'
alias all='kc get all'
alias svc='kc get svc'
alias ws='cd /c/Users/KBiawat/Shelf/Workspaces'
alias sl='cd /c/Users/KBiawat/Shelf/Shitloads'

# Nix
alias din='echo "use nix" > .envrc && echo "watch_file nix/*" >> .envrc && di'
alias nfu='nix flake update'
alias nix-shell-q='echo -e ${buildInputs// /\\n} | cut -d - -f 2- | sort' # like nix-env -q
alias nix-shell-qq='echo -e ${buildInputs// /\\n} | sort -t- -k2,2 -k3,3' # like nix-env -q

# Nix Home Manager
alias hm='home-manager'
alias hml='/c/Users/KBiawat/Shelf/Workspaces/experiments/.dotfiles'
alias hmd='cd /c/Users/KBiawat/Shelf/Workspaces/experiments/.dotfiles/nix/home-manager'
alias stwd='cd /c/Users/KBiawat/Shelf/Workspaces/experiments/.dotfiles/stow'
alias hmgd='home-manager generations | head -n 2 | tac | cut -d " " -f 7 | xargs nix store diff-closures'
alias hmp='home-manager packages'
#home-manager switch --flake .#kbiawat, when you already in that directory
alias hms='home-manager switch --flake /c/Users/KBiawat/Shelf/Workspaces/experiments/.dotfiles/nix/home-manager#kbiawat && hmgd'
#alias hmu='nix flake update --flake /c/Users/KBiawat/Shelf/Workspaces/experiments/.dotfiles/nix/home-manager#kbiawat && hms'
alias hmu='nix flake update && hms' # use hmd first as above did not work for some reason
alias hmh='vi /c/Users/KBiawat/Shelf/Workspaces/experiments/.dotfiles/nix/home-manager/home.nix'

case "$(uname -s)" in

Darwin)
	# echo 'Mac OS X'
	alias ls='ls -G'
	;;

Linux)
	alias ls='ls --color=auto'
	;;

CYGWIN* | MINGW32* | MSYS* | MINGW*)
	# echo 'MS Windows'
	;;
*)
	# echo 'Other OS'
	;;
esac
