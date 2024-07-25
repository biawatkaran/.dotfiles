# Using Dotfiles

## Overall

* Install Nix setup first
* Install zsh (without nix) `sudo apt install zsh` installed via nix sometimes creates problem and omz not able to update itself etc (did not explore too much)
* Install Zap (without nix as not present) - `zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1`
* Install ohmyzsh (with/out nix), then also you need to rename bkp zshrc file etc, check troubleshooting section
* Now run Stow (already installed with nix) setup based on what you need e.g. for your own zshrc file
  * `mv ~/.zshrc ~/.zshrc.bak` and then `stow zsh -t ~` from the stow folder inside this repo which brings your own zshrc file 

## Nix Setup

* run directly `sudo apt update && sudo apt -y full-upgrade && sudo apt -y autoremove` or gm alias created ensure sudo is run first
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

## Nix uninstall
rm -rf /nix ~/.nix-channels ~/.nix-defexpr ~/.nix-profile
sudo rm -rf /etc/nix /etc/profile.d/nix.sh /etc/tmpfiles.d/nix-daemon.conf /nix ~root/.nix-channels ~root/.nix-defexpr ~root/.nix-profile

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
    * zap was giving problem with plug function
      * /nix/store/gamsi9qfsz5ncqnxzp98dj8s3hnxhs9w-user-environment/bin/dos2unix /home/kbiawat/.local/share/zap/*
      * commented out the zsh plugins in .zshrc file 
      * the final solution was -> git `autocrlf=input` in .gitconfig file
      * maybe optional after above (wsl --shutdown)
    * at same time zsh again was not working even though was present /home/kbiawat/.nix-profile/bin/zsh partially present
      * installed `sudo apt install zsh` first - probably best to install on its own maybe not via home.nix
      * removed zsh from home.nix
      * hmu run again
* Installed ohmyzsh using nix (yes we could all do that via programs.zsh.ohmyzsh enabled etc, i wanted to have my own zsh file so not enabled in home.nix)
  * if you have any ~/.oh-my-zsh folder then delete that or bkp
  * go to latest "/nix/store/hg81kn8jkhgsq794z2mvcsxgppjrz5r0-oh-my-zsh-2024-05-03/share/oh-my-zsh" #found using `la /nix/store | grep oh-my-zsh`
  * then `./tools/install.sh` did the ohmyzsh installation aka ~/.oh-my-zsh folder created 
  * then `mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc`
  * now you can enjoy ohmyzsh plugins with your own zshrc file

## References
* working PATH env variable: /home/kbiawat/.nix-profile/bin:/home/kbiawat/bin:/usr/local/bin:/home/kbiawat/.local/share/bob/nvim-bin:/home/kbiawat/.local/share/neovim/bin:/home/kbiawat/.fnm:/home/kbiawat/.local/share/go/bin:/home/kbiawat/.cargo/bin:/home/kbiawat/.docker/bin:/home/kbiawat/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/c/Program Files (x86)/RSA SecurID Token Common:/c/Program Files/RSA SecurID Token Common:/c/WINDOWS/system32:/c/WINDOWS:/c/Users/KBiawat/Shelf/DevTools/GoLand 2023.1.3/bin:/c/WINDOWS/System32/Wbem:/c/WINDOWS/System32/WindowsPowerShell/v1.0/:/c/WINDOWS/System32/OpenSSH/:/c/Program Files/dotnet/:/c/ProgramData/chocolatey/bin:/c/Program Files (x86)/Enterprise Vault/EVClient/x64/:/c/Program Files/Amazon/AWSCLIV2/:/c/Users/KBiawat/AppData/Local/Programs/Python/Python311/Scripts/:/c/Users/KBiawat/AppData/Local/Programs/Python/Python311/:/c/WINDOWS/system32/config/systemprofile/AppData/Local/Microsoft/WindowsApps:/c/Users/KBiawat/Shelf/DevTools/Git/cmd:/c/Users/KBiawat/Shelf/DevTools/GoLand 2023.1.3/bin:/c/Users/KBiawat/Shelf/DevTools/PyCharm 2023.1.2/bin:/c/Users/KBiawat/AppData/Local/Programs/Microsoft VS Code/bin:/c/Users/KBiawat/Shelf/DevTools/Lens/resources/cli/bin:/c/Program Files/Amazon/AWSCLIV2:/c/Users/KBiawat/Documents/WindowsPowerShell/Scripts:/c/Users/KBiawat/Shelf/Workspaces/golang_ws:/c/Users/KBiawat/Shelf/Workspaces/golang_ws/bin