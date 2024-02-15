#!/bin/bash
echo "clearing dotfile repo directory"
if [ -d "/nvim" ]; then
    rm -r nvim
fi

if [ -d "/i3" ]; then
    rm -r i3
fi

if [ -d "/rofi" ]; then
    rm -r rofi
fi

if [ -d "/.icons" ]; then
    rm -r .icons
fi

if [ -d "/.themes" ]; then
    rm -r .themes
fi

if [ -d "/powerline" ]; then
    rm -r powerline
fi

echo "copying powerline"
cp -r ~/.config/powerline .

echo "copying gtk files"
cp -r ~/.icons .
cp -r ~/.themes .

echo "copying rofi"
cp -r ~/.config/rofi .

echo "copying i3"
cp -r ~/.config/i3 .

echo "copying nvim files in to repo"
cp -r ~/.config/nvim .

echo "copying zshrc"
cp ~/.zshrc .


# copy apt details
dpkg --get-selections > Package.list
sudo cp -R /etc/apt/sources.list* 
