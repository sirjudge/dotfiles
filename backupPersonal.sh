#!/bin/bash
action=$1
clean=$2
backup=$3

if [ "$backup" = "1" ]; then
    echo "backing up personal setup"
    if [ ! -d ~/.config/config_backup ]; then
        mkdir ~/.config/config_backup
    fi

    cp -r ~/.config/i3 ~/.config/config_backup
    cp -r ~/.config/nitrogen ~/.config/config_backup/nitrogen
    cp -r ~/.config/rofi ~/.config/config_backup/rofi
    cp -r ~/.config/polybar ~/.config/config_backup/polybar
    cp -r ~/.config/picom ~/.config/config_backup/picom
    cp -r ~/Tools/Scripts/ ~/.config/config_backup/picom
    cp -r ~/.config/i3status-rust ~/.config/config_backup/i3status-rust

    echo "finished backuing up personal setup"
fi

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


    echo "finished restoring personal setup"
    rsync -a ~/personal/i3 ~/.config/
    rsync -a ~/personal/nitrogen ~/.config/
    rsync -a ~/personal/rofi ~/.config/
    rsync -a ~/personal/polybar ~/.config/
    rsync -a ~/personal/picom ~/.config/
    rsync -a ~/personal/Scripts ~/Tools/
    rsync -a ~/personal/i3status-rust ~/.config/
    exit 0
fi


if [ "$action" = "backup" ]; then
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
