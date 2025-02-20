#!/bin/bash
# Declare input args
action="$1"
clean="$2"
sourceBackup="$3"

# check if we should restore source backup
if [ "$sourceBackup" = "true" ]; then
    dpkg --get-selections > ~/solutions/dotfiles/work/Package.list
    sudo cp -R /etc/apt/sources.list* ~/solutions/dotfiles/work/
fi

# Clean existing files and folders
# copy or back up office files
if [ "$action" = "restore" ]; then
    if [ "$clean" = "true" ]; then
        echo "cleaning existing .config files in office setup"
        rm -r ~/.config/powerline
        rm ~/.zshrc
    fi

    # copy files from this repo to the .config fodler location
    echo "restoring office setup"
    rsync -a ~/solutions/dotfiles/work/powerline ~/.config/
    rsync -a ~/solutions/dotfiles/work/.zshrc ~/
    echo "finished restoring office setup"
fi

if [ "$action" = "backup" ]; then
    # delete current work folder
    if [ "$clean" = "true" ]; then
        echo "cleaning existing files and folders from work/ backup folder"
        rm -rf ~/solutions/dotfiles/work/*
    fi
    # Remake new directory folders
    if [ ! -d ~/solutions/dotfiles/work ]; then
        mkdir ~/solutions/dotfiles/work/
    fi

    echo "backing up office setup"
    rsync -a ~/.config/powerline ~/solutions/dotfiles/work/powerline
    rsync -a ~/.zshrc ~/solutions/dotfiles/work/
fi
