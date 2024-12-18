#!/bin/bash

# Declare input args
action="$1"
clean="$2"

# Clean existing files and folders
# copy or back up office files
if [ "$action" = "restore" ]; then
    if [ "$clean" = "true" ]; then
        echo "cleaning existing .config files in office setup"
        rm -r ~/.config/powerline
        rm -r ~/.config/rofi
        rm ~/.zshrc
    fi
    echo "restore office setup"
elif [ "$action" = "backup" ]; then
    # delete current work folder
    if [ "$clean" = "true" ]; then
        echo "cleaning existing files and folders from work/ backup folder"
        rm -rf ~/solutions/dotfiles/work/*
    fi
    # Remake new directory folders
    if [ ! -d ~/solutions/dotfiles/work ]; then
        mkdir ~/solutions/dotfiles/work/
        mkdir ~/solutions/dotfiles/work/tmux
        mkdir ~/solutions/dotfiles/work/icons
        mkdir ~/solutions/dotfiles/work/fonts
    fi

    echo "backing up office setup"
    rsync -a ~/.config/powerline ~/solutions/dotfiles/work/powerline
    rsync -a ~/.config/rofi ~/solutions/dotfiles/work/rofi
    rsync -a ~/.zshrc ~/solutions/dotfiles/work/
fi
