#!/bin/bash
while getopts 'a:s:h:c:so' flag; do
    case "${flag}" in
        a) action="${OPTARG}" ;;
        s) setup="${OPTARG}" ;;
        c) clean="${OPTARG}" ;;
        so) sourceBackup="${OPTARG}" ;;
        h) echo "a => [a]ction (restore/backup)\n"\
            "s => [s]etup to work on (office/personal)\n"\
            "c => [c]lean existing files and folders\n"\
            "so => [so]urce list backup\n"\
            "example Usage: Monitor.sh -a backup -s office -c true"
            exit 1 ;;
    esac
done

if [ "$setup" = "office" ]; then
    # Clean existing files and folders
    # copy or back up office files
    if [ "$action" = "restore" ]; then
        if [ "$clean" = "true" ]; then
            echo "cleaning existing files and folders"
            rm -r ~/.config/powerline
            rm -r ~/.config/rofi
            rm -r ~/.icons
            rm -r ~/.fonts
            rm ~/.zshrc
        fi
        echo "restore office setup"
    elif [ "$action" = "backup" ]; then
        # delete current work folder
        if [ "$clean" = "true" ]; then
            echo "cleaning existing files and folders"
            rm -rf work/*
        fi
        # Remake new directory folders
        if [ ! -d "work" ]; then
            mkdir work
            mkdir work/tmux
            mkdir work/icons
            mkdir work/fonts
        fi

        echo "backing up office setup"
        cp -r ~/.config/powerline work/powerline
        cp -r ~/.config/rofi work/rofi
        cp -r ~/.icons work/icons
        cp -r ~/.fonts/ work/
        cp -r ~/.themes/ work/
        cp -r ~/.zshrc work/
    fi
elif [ "$setup" = "personal" ]; then
    # copy or back up personal files
    if [ "$action" = "restore" ]; then
        if [ "$clean" = "true" ]; then
            echo "cleaning existing files and folders"
            rm -r ~/.config/i3
            rm -r ~/.config/nitrogen
            rm -r ~/.config/rofi
            rm -r ~/.config/polybar
            rm -r ~/.config/picom
        fi
        echo "copying personal setup"
    elif [ "$action" = "backup" ]; then
        if [ "$clean" = "true" ]; then
            echo "cleaning existing files and folders"
            rm -r personal/*
        fi
        echo "backing up personal setup"
        cp -r ~/.config/i3 personal/
        cp -r ~/.config/nitrogen personal/
        cp -r ~/.config/rofi personal/
        cp -r ~/.config/polybar personal/
        cp -r ~/.config/picom personal/
        cp -r ~/.fonts personal/
        cp -r ~/Tools/scripts personal/
        cp -r ~/.config/i3status-rust personal/
    fi
fi

# Shared folders to restore
if [ "$sourceBackup" = "true" ]; then
    dpkg --get-selections > work/Package.list
    sudo cp -R /etc/apt/sources.list* work/
fi

if [ "$clean" = "true" ]; then
    echo "cleaning existing files and folders"
    if [ "$action" = "copy" ]; then
        rm -r ~/.config/nvim
        rm -r ~/.config/tmux
        rm -r ~/.config/kitty
        rm ~/solutions/.editorconfig
    elif [ "$action" = "backup" ]; then
        rm -r shared/nvim
        rm -r shared/tmux
        rm -r shared/kitty
        rm shared/.editorconfig
    fi
fi

if [ "$action" = "restore" ]; then
    echo "restoring shared files"
    cp -r shared/nvim ~/.config/
    cp -r shared/tmux ~/.config/
    cp -r shared/kitty ~/.config/
    cp -r shared/.editorconfig ~/solutions/
elif [ "$action" = "backup" ]; then
    echo "backing up shared files"
    if [ ! -d "shared/tmux" ]; then
        mkdir shared/tmux
    fi
    cp -r ~/.config/nvim ~/shared/
    cp -r ~/.config/tmux/tmux.conf shared/tmux/
    cp -r ~/.config/kitty shared/
    cp -r ~/solutions/.editorconfig shared/
fi
