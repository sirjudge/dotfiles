#!/bin/bash

if [ -d "~/.config/nvim" ]; then
    echo "cleaning and remaking nvim"
    rm -r ~/.config/nvim 
    mkdir ~/.config/nvim 
else
    echo "making nvim"
    mkdir ~/.config/nvim
fi  

echo "choping nvim files out of repo"
cp -r nvim/* ~/.config/nvim

