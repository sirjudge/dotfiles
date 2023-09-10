echo "copying neovim config folder and zipping"
cp ~/.config/nvim .
zip -r nvim.zip nvim

echo "copying zshrc"
cp ~/.zshrc .

echo "pushing to git"
git pull
git add .
git commit -m "update dotfiles from script"
git push
