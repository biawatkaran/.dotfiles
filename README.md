# Using Dotfiles

## Overall

* Run Nix setup first
  * you already have zsh installed with nix so `zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1`
  * if you install ohmyzsh then also you need to rename bkp zshrc file etc, check troubleshooting section
* Now run Stow setup based on what you need e.g. for zsh you might need to remove the auto generated zshrc file
  * `mv ~/.zshrc ~/.zshrc.bak` and then `stow zsh -t ~` from the stow folder inside this repo 

## Nix Setup

* sudo apt update && sudo apt -y full-upgrade && sudo apt -y autoremove
* sh <(curl -L https://nixos.org/nix/install) --no-daemon
  * verify: nix-shell -p nix-info --run "nix-info -m"
  * echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
* Run: `nix run home-manager/release-24.05 -- init ~/.dotfiles/nix/home-manager` (will create folder etc, --switch ll activate)
  * now you can review flake.nix and home.nix files
  * once happy add --switch
* Build: `nix build .#homeConfigurations.kbiawat.activationPackage`
  * make changes in file, and running above will build aka store files in nix/store not activated or those packages not available yet  
* Activate:
  * `nix run home-manager/release-23.11 -- init ~/.dotfiles/nix/home-manager --switch`
  * (or) after nix build command symlink activation `results/activate`
    * in fact `nix-env -q` will show all the packages installed
* Download packages: once home-manager installed, then add in home.nix more packages. `home-manager switch --flake ath-to-flake-file>`
  * `home-manager switch` expects home.nix at default path `~/.config/home-manager/home.nix`
  * as we used flake so `home-manager switch --flake .#kbiawat` because we activated that package profile
    * `home-manager packages` will show all the packages installed
    * we have formatter in our sample flake.nix file so use `nix fmt` to format

### Usage

* `cd <where-you-cloned>.dotfiles/nix/home-manager` aka to hmd alias
* `update home.nix` with new packages
  * search for packages here https://search.nixos.org/packages
* `home-manager switch --flake .#kbiawat`

## Stow

You can install stow using nix too. Most of the tools are configured to be in `~/.config` folder. So, we can use `stow` to symlink them to the home directory.
* consider every folder inside stow to be as if you are in home directory, and configure the files inside that sub-package folder accordingly
e.g. stow/wezterm folder === ~ folder, so whatever is inside wezterm folder should get symlinked from ~
* wezterm folder has .config/wezterm/wezterm.lua
* since wezterm folder is equivalent to home-directory
* go to home-directory/.config/ directory, you will see `wezterm --symlinked-> ../.dotfiles/stow/wezterm/.config/
wezterm/`
* as if ~/.config/wezterm/wezterms.lua exists (don't forget to use stow -t ~ * as described below)

### Usage
* `cd <where-you-cloned>.dotfiles/stow`
  * `stow -t ~ *` to symlink all the folders to home directory (by default its parent folder)
  * `stow -D -t ~ *` to remove symlinks

## Troubleshooting
* shell got f* up, then `wsl -d your-distro` from powershell should give you an exact error
  * I messed up my zsh with nixos, 
    * so temp `wsl -d Ubuntu -e chsh` brought that back to life by fixing problem
    * /home/kbiawat/.nix-profile/bin/zsh itself was not present
      * had to run Nix Setup section results/activate etc again, luckily /nix/store etc were already present
      * ran zap again from Overall section that backedup my .zshrc file, i had to restore that
* Installed ohmyzsh using nix (yes we could all do that via programs.zsh.ohmyzsh enabled etc, i wanted to have my own zsh file so not enabled in home.nix)
  * "/nix/store/hg81kn8jkhgsq794z2mvcsxgppjrz5r0-oh-my-zsh-2024-05-03/share/oh-my-zsh" #found using `la /nix/store | grep oh-my-zsh`
  * then `bin/install` did the ohmyzsh installation 
  * then `mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc`
  * now you can enjoy ohmyzsh plugins with your own zshrc file