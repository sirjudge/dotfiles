#!/bin/bash
action=$1
clean=$2

if [ "$action" = "restore" ]; then
    if [ "$clean" = "true" ]; then
        echo "cleaning .config/"
        rm -rf ~/.config/i3
        rm -rf ~/.config/nitrogen
        rm -rf ~/.config/rofi
        rm -rf ~/.config/polybar
        rm -rf ~/.config/picom
        rm -rf ~/Tools/Scripts
        rm -rf ~/.config/i3status-rust
    fi
    echo "copying personal setup"
elif [ "$action" = "backup" ]; then
    if [ "$clean" = "true" ]; then
        echo "cleaning dotfiles/peronsal/"
        rm -r ~/solutions/dotfiles/personal/*
    fi
    echo "backing up .config/ files to dotfiles/personal"
    rsync -a ~/.config/i3 ~/solutions/dotfiles/personal/
    rsync -a ~/.config/nitrogen ~/solutions/dotfiles/personal/
    rsync -a ~/.config/rofi ~/solutions/dotfiles/personal/
    rsync -a ~/.config/polybar ~/solutions/dotfiles/personal/
    rsync -a ~/.config/picom ~/solutions/dotfiles/personal/
    rsync -a ~/.fonts ~/solutions/dotfiles/personal/
    rsync -a ~/Tools/Scripts ~/solutions/dotfiles/personal/
    rsync -a ~/.config/i3status-rust ~/solutions/dotfiles/personal/
fi
