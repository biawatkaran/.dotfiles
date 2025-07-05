# gcloud auth login

teller env >stow/fabric/.config/fabric/.env

rm ~/.zshrc

cd stow
echo "## Stowing..."
stow -t ~ *
echo "## Done stowing..."

echo "## Follow the instructions at https://github.com/tonsky/FiraCode/wiki/VS-Code-Instructions to enable Fira Code in VS Code" \
    | gum format

echo '## Execute `source ~/.zshrc`.' | gum format
