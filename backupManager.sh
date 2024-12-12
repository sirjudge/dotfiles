#!/bin/bash
NEWLINE=$'\n'
while getopts 'a:s:c:so' flag; do
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

# Shared folders to restore
if [ "$sourceBackup" = "true" ]; then
    dpkg --get-selections > ~/solutions/dotfiles/work/Package.list
    sudo cp -R /etc/apt/sources.list* ~/solutions/dotfiles/work/
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
            rm -rf ~/solutions/dotfiles/work/*
        fi
        # Remake new directory folders
        if [ ! -d "~/solutions/dotfiles/work" ]; then
            mkdir ~/solutions/dotfiles/work/
            mkdir ~/solutions/dotfiles/work/tmux
            mkdir ~/solutions/dotfiles/work/icons
            mkdir ~/solutions/dotfiles/work/fonts
        fi

        echo "backing up office setup"
        rsync -a ~/.config/powerline ~/solutions/dotfiles/work/powerline
        rsync -a ~/.config/rofi ~/solutions/dotfiles/work/rofi
        rsync -a ~/.icons ~/solutions/dotfiles/work/icons
        rsync -a ~/.fonts/ ~/solutions/dotfiles/work/
        rsync -a ~/.themes/ ~/solutions/dotfiles/work/
        rsync -a ~/.zshrc ~/solutions/dotfiles/work/
    fi
elif [ "$setup" = "personal" ]; then
    # copy or back up personal files
    if [ "$action" = "restore" ]; then
        if [ "$clean" = "true" ]; then
            echo "cleaning existing files and folders"
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
            echo "cleaning existing files and folders"
            rm -r personal/*
        fi
        echo "backing up personal setup"
        rsync -a ~/.config/i3 personal/
        rsync -a ~/.config/nitrogen personal/
        rsync -a ~/.config/rofi personal/
        rsync -a ~/.config/polybar personal/
        rsync -a ~/.config/picom personal/
        rsync -a ~/.fonts personal/
        rsync -a ~/Tools/Scripts personal/
        rsync -a ~/.config/i3status-rust personal/
    fi
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
            rm -r ~/solutions/dotfiles/shared/nvim
        fi
        if [ -d "shared/tmux" ]; then
            rm -r ~/solutions/dotfiles/shared/tmux
        fi
        if [ -d "shared/kitty" ]; then
            rm -r ~/solutions/dotfiles/shared/kitty
        fi
        if [ -d "shared/alacritty" ]; then
            rm -r ~/solutions/dotfiles/shared/alacritty
        fi
        rm ~/solutions/dotfiles/shared/.editorconfig
    fi
fi

if [ "$action" = "restore" ]; then
    echo "restoring shared files"
    rsync -a ~/solutions/dotfiles/shared/nvim/ ~/.config/nvim/
    rsync -a ~/solutions/dotfiles/shared/tmux/ ~/.config/tmux/
    rsync -a ~/solutions/dotfiles/shared/kitty/ ~/.config/kitty/
    rsync -a ~/solutions/dotfiles/shared/alacritty/ ~/.config/alacritty/
    rsync -a ~/solutions/dotfiles/shared/.editorconfig ~/solutions/
elif [ "$action" = "backup" ]; then
    echo "backing up shared files"

    # create shared folder if it does not exist
    if [ ! -d "shared" ]; then
        mkdir shared
    fi

    if [ ! -d "shared/tmux" ]; then
        mkdir ~/solutions/dotfiles/shared/tmux
    fi
    # we only want to backup the tmux.conf file and
    # not the entire tmux folder because plugins are installed
    cp ~/.config/tmux/tmux.conf ~/solutions/dotfiles/shared/tmux/.

    # back up the rest of the configs as normal
    rsync -a ~/.config/nvim/ ~/solutions/dotfiles/shared/nvim/
    rsync -a ~/.config/kitty/ ~/solutions/dotfiles/shared/kitty/
    rsync -a ~/.config/alacritty/ ~/solutions/dotfiles/shared/alacritty/
    rsync -a ~/solutions/.editorconfig ~/solutions/dotfiles/shared/
fi
