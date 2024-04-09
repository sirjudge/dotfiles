#!/bin/bash

echo "zipping current config folder"
zip -r config.zip ~/.config

echo "clearing dotfile repo directory"
if [ -d "/nvim" ]; then
    rm -r nvim
fi
echo "copying nvim files in to repo"
cp -r ~/.config/nvim .

echo "copying zshrc"
cp ~/.zshrc .



