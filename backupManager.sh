#!/bin/bash
# Configure new line and take in command line arguments
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

# Run office specific tasks
if [ "$setup" = "office" ]; then
    # Clean existing files and folders
    # copy or back up office files
    if [ "$action" = "restore" ]; then
        if [ "$clean" = "true" ]; then
            echo "cleaning existing .config files in office setup"
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
        rsync -a ~/.icons ~/solutions/dotfiles/work/icons
        rsync -a ~/.fonts/ ~/solutions/dotfiles/work/
        rsync -a ~/.themes/ ~/solutions/dotfiles/work/
        rsync -a ~/.zshrc ~/solutions/dotfiles/work/
    fi
# Run personal specific tasks
elif [ "$setup" = "personal" ]; then
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
fi

# Run cleanup on shared files
if [ "$clean" = "true" ]; then
    if [ "$action" = "copy" ]; then
        echo "cleaning shared .config/ folders"
        rm -r ~/.config/nvim
        rm -r ~/.config/tmux
        rm -r ~/.config/kitty
        rm -r ~/.config/alacritty
        rm -r ~/.config/tmux
        rm ~/solutions/.editorconfig
    elif [ "$action" = "backup" ]; then
        echo "cleaning dotfiles/shared/"
        if [ -d ~/solutions/dotfiles/shared/nvim ]; then
            rm -r ~/solutions/dotfiles/shared/nvim
        fi
        if [ -d ~/solutions/dotfiles/shared/tmux ]; then
            rm -r ~/solutions/dotfiles/shared/tmux
        fi
        if [ -d ~/solutions/dotfiles/shared/kitty ]; then
            rm -r ~/solutions/dotfiles/shared/kitty
        fi
        if [ -d ~/solutions/dotfiles/shared/alacritty ]; then
            rm -r ~/solutions/dotfiles/shared/alacritty
        fi
        if [ -f ~/solutions/.editorconfig ]; then
            rm ~/solutions/dotfiles/shared/.editorconfig
        fi
    fi
fi

# restore or backup shared files
if [ "$action" = "restore" ]; then
    echo "restoring dotfiles/shared to .config/ folders"
    rsync -a ~/solutions/dotfiles/shared/nvim/ ~/.config/nvim/
    rsync -a ~/solutions/dotfiles/shared/tmux/ ~/.config/tmux/
    rsync -a ~/solutions/dotfiles/shared/kitty/ ~/.config/kitty/
    rsync -a ~/solutions/dotfiles/shared/alacritty/ ~/.config/alacritty/
    rsync -a ~/solutions/dotfiles/shared/.editorconfig ~/solutions/
elif [ "$action" = "backup" ]; then
    echo "backing up shared .config/ folders"

    # create shared folder if it does not exist
    if [ ! -d ~/solutions/dotfiles/shared ]; then
        echo "creating dotfiles/shared folder"
        mkdir ~/solutions/dotfiles/shared
    fi

    if [ ! -d ~/solutions/dotfiles/shared/tmux ]; then
        echo "creating tmux folder in dotfiles/shared folder"
        mkdir ~/solutions/dotfiles/shared/tmux
    fi

    echo "copying tmux config to dotfiles/shared/tmux"
    cp ~/.config/tmux/tmux.conf ~/solutions/dotfiles/shared/tmux/.

    echo "backing up nvim, kitty, alacritty, and .editor config"
    rsync -a ~/.config/nvim/ ~/solutions/dotfiles/shared/nvim/
    rsync -a ~/.config/kitty/ ~/solutions/dotfiles/shared/kitty/
    rsync -a ~/.config/alacritty/ ~/solutions/dotfiles/shared/alacritty/
    rsync -a ~/solutions/.editorconfig ~/solutions/dotfiles/shared/
fi
