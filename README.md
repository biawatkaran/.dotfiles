# Using Dotfiles

## Nix Way
* NOTE Preferred simpler way [Devbox](#devbox-way)
* This method is more for seasoned nix users, sometimes has difficulties

### Terms
* nix packages are defined as derivations
* derivation is function with package dependencies and package configuration as its inputs, and plan on how to build the package as its output
* nix evaluates that function and builds its output will then be stored in nix store /nix/store/sha256-of-derivation-packagename
* nix uses channel to declare what version of nixpkgs you running and that state is external to your package means we need to pull from multiple places
  * to solve this, nix flake was introduced
* nix-flake: flake.nix will have external inputs and all outputs of flake are defined

### Overall

* Install Nix setup first
* Install Zap (without nix as not present) - `zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1`
* Install ohmyzsh (with/out nix), then also you need to rename bkp zshrc file etc, check troubleshooting section
* Now run Stow (already installed with nix) setup based on what you need e.g. for your own zshrc file
  * `mv ~/.zshrc ~/.zshrc.bak` and then `stow zsh -t ~` from the stow folder inside this repo which brings your own zshrc file 

#### Nix Setup
* https://zero-to-nix.com/start/install `curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install` 
  * first time got an error, possibly was blocked by infosec and later approval itself in next terminal allowed it to install
  * verify: nix run "nixpkgs#hello"
  * the installation gets this added already so no need : echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
* Run: `nix run home-manager/release-24.05 -- init ~/.dotfiles/nix/home-manager` (will create folder etc, --switch ll activate)
  * now you can review flake.nix and home.nix files
  * once happy add --switch
* Build: `nix build .#homeConfigurations.kbiawat.activationPackage`
  * make changes in file, and running above will build aka store files in nix/store not activated or those packages not available yet  
* Activate:
  * `nix run home-manager/release-23.11 -- init ~/.dotfiles/nix/home-manager --switch`
  * (or) after nix build command symlink activation `results/activate`
    * in fact `nix-env -q` will show all the packages installed
* Download packages: once home-manager installed, then add in home.nix more packages. `home-manager switch --flake <path-to-flake-file>`
  * `home-manager switch` expects home.nix at default path `~/.config/home-manager/home.nix`
  * as we used flake so `home-manager switch --flake .#kbiawat` because we activated that package profile
    * `home-manager packages` will show all the packages installed
    * we have formatter in our sample flake.nix file so use `nix fmt` to format

##### Nix uninstall
rm -rf /nix ~/.nix-channels ~/.nix-defexpr ~/.nix-profile
sudo rm -rf /etc/nix /etc/profile.d/nix.sh /etc/tmpfiles.d/nix-daemon.conf /nix ~root/.nix-channels ~root/.nix-defexpr ~root/.nix-profile

##### Usage

* `cd <where-you-cloned>.dotfiles/nix/home-manager` aka to hmd alias
* `update home.nix` with new packages
  * search for packages here https://search.nixos.org/packages
* `home-manager switch --flake .#kbiawat`

### Troubleshooting

* got ssl error even running simple ix run nixpkgs#hello
  * https://github.com/NixOS/nix/issues/8081 solved it

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


## Devbox Way

* install git and homebrew first
* git clone this repo on local at ~ directory
  * run ./install.sh
  * make sure you can the zap separately, its at the bottom of that install.sh file
* run `devbox shell` so that all the tools devbox.json get installed
* now run ./sync.sh



## References

* working PATH env variable: /home/kbiawat/.nix-profile/bin:/home/kbiawat/bin:/usr/local/bin:/home/kbiawat/.local/share/bob/nvim-bin:/home/kbiawat/.local/share/neovim/bin:/home/kbiawat/.fnm:/home/kbiawat/.local/share/go/bin:/home/kbiawat/.cargo/bin:/home/kbiawat/.docker/bin:/home/kbiawat/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/c/Program Files (x86)/RSA SecurID Token Common:/c/Program Files/RSA SecurID Token Common:/c/WINDOWS/system32:/c/WINDOWS:/c/Users/KBiawat/Shelf/DevTools/GoLand 2023.1.3/bin:/c/WINDOWS/System32/Wbem:/c/WINDOWS/System32/WindowsPowerShell/v1.0/:/c/WINDOWS/System32/OpenSSH/:/c/Program Files/dotnet/:/c/ProgramData/chocolatey/bin:/c/Program Files (x86)/Enterprise Vault/EVClient/x64/:/c/Program Files/Amazon/AWSCLIV2/:/c/Users/KBiawat/AppData/Local/Programs/Python/Python311/Scripts/:/c/Users/KBiawat/AppData/Local/Programs/Python/Python311/:/c/WINDOWS/system32/config/systemprofile/AppData/Local/Microsoft/WindowsApps:/c/Users/KBiawat/Shelf/DevTools/Git/cmd:/c/Users/KBiawat/Shelf/DevTools/GoLand 2023.1.3/bin:/c/Users/KBiawat/Shelf/DevTools/PyCharm 2023.1.2/bin:/c/Users/KBiawat/AppData/Local/Programs/Microsoft VS Code/bin:/c/Users/KBiawat/Shelf/DevTools/Lens/resources/cli/bin:/c/Program Files/Amazon/AWSCLIV2:/c/Users/KBiawat/Documents/WindowsPowerShell/Scripts:/c/Users/KBiawat/Shelf/Workspaces/golang_ws:/c/Users/KBiawat/Shelf/Workspaces/golang_ws/bin
 * on Mac: /Users/mktxmac-kbiawat/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Applications/iTerm.app/Contents/Resources/utilities
* https://nixcademy.com/posts/nix-on-macos/ (recent with nix-darwin)
* https://blog.6nok.org/how-i-use-nix-on-macos/
  * https://xyno.space/post/nix-darwin-introduction
* https://nixcademy.com/cheatsheet/
* https://discourse.nixos.org/t/ssl-ca-cert-error-on-macos/31171/6
* devbox setup https://github.com/vfarcic/dotfiles
