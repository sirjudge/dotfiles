#!/bin/bash
while getopts 'a:s:h:c' flag; do
    case "${flag}" in
        a) action="${OPTARG}" ;;
        s) setup="${OPTARG}" ;;
        c) clean="${OPTARG}" ;;
        h) echo "a => [a]ction (restore/backup)\n"\
            "s => [s]etup to work on (office/personal)\n"\
            "c => [c]lean existing files and folders\n"\
            "example Usage: Monitor.sh -a backup -s office -c true;"
            exit 1 ;;
    esac
done

if [ "$setup" = "office" ]; then
    # Clean existing files and folders
    # copy or back up office files
    if [ "$action" = "restore" ]; then
        if [ "$clean" = "true" ]; then
            echo "cleaning existing files and folders"
            #TODO: remove existing config sections
        fi
        echo "restore office setup"
    elif [ "$action" = "backup" ]; then
        if [ "$clean" = "true" ]; then
            echo "cleaning existing files and folders"
            rm -r work/*
        fi


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
        cp -r ~/.fonts work/fonts
        cp -r ~/.themes work/themes
        cp -r ~/.zshrc work/
        # copy currently installed packages and sources
        dpkg --get-selections > work/Package.list
        sudo cp -R /etc/apt/sources.list* work/
    fi
elif [ "$setup" = "personal" ]; then
    # copy or back up personal files
    if [ "$action" = "restore" ]; then
        if [ "$clean" = "true" ]; then
            echo "cleaning existing files and folders"
            rm -r personal/*
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
        cp -r ~/.config/eww personal/
        cp -r ~/.config/rofi personal/
        cp -r ~/.config/polybar personal/
        cp -r ~/.config/i3status personal/
        cp -r ~/.fonts personal/
        cp -r ~/Tools/scripts personal/
    fi
fi

# Shared folders to restore
if [ "$clean" = "true" ]; then
    echo "cleaning existing files and folders"
    if [ "$action" = "copy" ]; then
        rm -r ~/.config/nvim
        rm -r ~/.config/tmux
        rm -r ~/.config/kitty
    elif [ "$action" = "backup" ]; then
        rm -r shared/nvim
        rm -r shared/tmux
        rm -r shared/kitty
    fi
fi

if [ "$action" = "restore" ]; then
    echo "restoring shared files"
    cp -r shared/nvim ~/.config/
    cp -r shared/tmux ~/.config/
    cp -r shared/kitty ~/.config/
elif [ "$action" = "backup" ]; then
    echo "backing up shared files"
    cp -r ~/.config/nvim ~/shared/
    if [ ! -d "shared/tmux" ]; then
        mkdir shared/tmux
    fi
    cp -r ~/.config/tmux/tmux.conf shared/tmux/
    cp -r ~/.config/kitty shared/
fi
