#!/bin/bash
echo "starting to copy dotfiles\ncopying i3"
cp -r ~/.config/i3 ~/Documents/dotfiles/
echo "copying polybar"
cp -r ~/.config/polybar ~/Documents/dotfiles/
echo "copying termminator"
cp -r ~/.config/terminator ~/Documents/dotfiles/
echo "copying .zshrc"
cp ~/.zshrc ~/Documents/dotfiles/
echo "copying vimrc"
cp ~/.vimrc ~/Documents/dotfiles/
echo "files have all been copied"
