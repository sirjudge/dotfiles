#!/bin/bash
echo "clearing dotfile repo directory"
if [ -d "/nvim" ]; then
    rm -r nvim
fi


echo "copying nvim files in to repo"
cp -r ~/.config/nvim .


echo "push to git"
git pull
git add .

#bring these back in later
#echo "copying .zshrc"
#cp ~/.zshrc ~/Documents/repos/dotfiles/
#echo "copying vimrc"
#cp ~/.vimrc ~/Documents/repos/cdotfiles/
#echo "files have all been copied"
