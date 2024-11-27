#!/bin/bash
NEWLINE=$'\n'
while getopts 'a:s:hc:so' flag; do
    case "${flag}" in
        a) action="${OPTARG}" ;;
        s) setup="${OPTARG}" ;;
        c) clean="${OPTARG}" ;;
        so) sourceBackup="${OPTARG}" ;;
        h) echo\
            "a => [a]ction (restore/backup)${NEWLINE}"\
            "s => [s]etup to work on (office/personal)${NEWLINE}"\
            "c => [c]lean existing files and folders${NEWLINE}"\
            "so => [so]urce list backup${NEWLINE}"\
            "example Usage: Monitor.sh -a  backup -s office -c true"
            exit 1 ;;
    esac
done

# Validation
if [ "$setup" = "" ]; then
    echo "Please provide a setup to work on using the -s flag: '-s {office/personal}'${NEWLINE}"
    exit 1
fi

if [ "$action" = "" ]; then
    echo "Please provide an action to perform using the -a flag: '-a {restore/backup}'${NEWLINE}"
    exit 1
fi

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
        rsync -r ~/.config/powerline work/powerline
        rsync -r ~/.config/rofi work/rofi
        rsync -r ~/.icons work/icons
        rsync -r ~/.fonts/ work/
        rsync -r ~/.themes/ work/
        rsync -r ~/.zshrc work/
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
            rm -r ~/.config/macchina
        fi
        echo "copying personal setup"
    elif [ "$action" = "backup" ]; then
        if [ "$clean" = "true" ]; then
            echo "cleaning existing files and folders"
            rm -r personal/*
        fi
        echo "backing up personal setup"
        rsync -r ~/.config/i3 personal/
        rsync -r ~/.config/nitrogen personal/
        rsync -r ~/.config/rofi personal/
        rsync -r ~/.config/polybar personal/
        rsync -r ~/.config/picom personal/
        rsync -r ~/.fonts personal/
        rsync -r ~/Tools/scripts personal/
        rsync -r ~/.config/i3status-rust personal/
        rsync -r ~/.config/macchina personal/
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
        if [ -d "shared/nvim" ]; then
            rm -r shared/nvim
        fi
        if [ -d "shared/tmux" ]; then
            rm -r shared/tmux
        fi
        if [ -d "shared/kitty" ]; then
            rm -r shared/kitty
        fi
        rm shared/.editorconfig
    fi
fi

if [ "$action" = "restore" ]; then
    echo "restoring shared files"
    rsync -r shared/nvim ~/.config/
    rsync -r shared/tmux ~/.config/
    rsync -r shared/kitty ~/.config/
    rsync -r shared/.editorconfig ~/solutions/
elif [ "$action" = "backup" ]; then
    echo "backing up shared files"
    if [ ! -d "shared/tmux" ]; then
        mkdir shared/tmux
    fi
    rsync -r ~/.config/nvim ~/shared/
    rsync -r ~/.config/tmux/tmux.conf shared/tmux/
    rsync -r ~/.config/kitty shared/
    rsync -r ~/solutions/.editorconfig shared/
fi
