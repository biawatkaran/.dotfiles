brew install font-fira-code-nerd-font

# https://github.com/zdharma-continuum/zinit?tab=readme-ov-file#install
bash -c "$(curl --fail --show-error --silent \
    --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# https://github.com/tonsky/FiraCode/wiki/Installing
brew install --cask font-fira-code

# https://www.kcl-lang.io/docs/user_docs/getting-started/install#homebrew-macos-1
brew install kcl-lang/tap/kcl-lsp

# https://www.jetify.com/devbox/docs/installing_devbox/
curl -fsSL https://get.jetify.com/devbox | bash

# https://obsproject.com/kb/mac-installation#homebrew
brew install --cask obs

# https://github.com/hidetatz/kubecolor
brew install kubecolor

# https://github.com/sharkdp/bat
brew install bat

# https://github.com/zap-zsh/zap - had to run explicitly
#zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

