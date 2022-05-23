#!/bin/bash
echo "clearing dotfile repo directory"
rm -r ~/Documents/repos/dotfiles/i3/
rm ~/Documents/repos/dotfiles/.vimrc
rm  ~/Documents/repos/dotfiles/.zshrc

echo "starting to copy dotfiles\ncopying i3"
cp -r ~/.config/i3 ~/Documents/repos/dotfiles/
echo "copying polybar"
cp -r ~/.config/polybar ~/Documents/repos/dotfiles/
echo "copying termminator"
cp -r ~/.config/terminator ~/Documents/repos/dotfiles/
echo "copying .zshrc"
cp ~/.zshrc ~/Documents/repos/dotfiles/
echo "copying vimrc"
cp ~/.vimrc ~/Documents/repos/cdotfiles/
echo "files have all been copied"
