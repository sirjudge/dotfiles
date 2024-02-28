#!/bin/bash

# nvim
if [ -d "/nvim" ]; then
    rm -r nvim
fi
echo "copying nvim files in to repo"
cp -r ~/.config/nvim .

# i3
if [ -d "/i3" ]; then
    rm -r i3
fi
echo "copying i3"
cp -r ~/.config/i3 .


# Rofi
if [ -d "/rofi" ]; then
    rm -r rofi
fi
echo "copying rofi"
cp -r ~/.config/rofi .

# GTK themes and icons
if [ -d "/.icons" ]; then
    rm -r .icons
fi
if [ -d "/.themes" ]; then
    rm -r .themes
fi
echo "copying gtk files"
cp -r ~/.icons .
cp -r ~/.themes .

# Powerline
if [ -d "/powerline" ]; then
    rm -r powerline
fi
echo "copying powerline"
cp -r ~/.config/powerline .

# zshrc
echo "copying zshrc"
cp ~/.zshrc .

# copy apt details
dpkg --get-selections > Package.list
sudo cp -R /etc/apt/sources.list* 
