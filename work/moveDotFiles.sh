#!/bin/bash
echo "clearing dotfile repo directory"
if [ -d "/nvim" ]; then
    rm -r nvim
fi

if [-d "/i3"]; then
    rm -r i3
fi

if [-d "/rofi"]; then
    rm -r rofi
fi

echo "copying rofi"
cp -r ~/.config/rofi .

echo "copying i3"
cp -r ~/.config/i3 .

echo "copying nvim files in to repo"
cp -r ~/.config/nvim .

echo "copying zshrc"
cp ~/.zshrc .

echo "push to git"
git pull
git add ../.
git commit -m "update dotfiles from script"
git push


