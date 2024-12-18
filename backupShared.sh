#!/bin/bash
# Declare input args
action="$1"
clean="$2"
backup="$3"
# ============== CLEAN UP ==============
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

# ============== BACKUP ==============
if [ "$backup" = "1" ]; then
    echo "backing up personal setup"
    if [ ! -d ~/.config/config_backup ]; then
        mkdir ~/.config/config_backup
    fi
    cp -r ~/.config/nvim ~/.config/config_backup/nvim
    cp -r ~/.config/tmux ~/.config/config_backup/tmux
    cp -r ~/.config/kitty ~/.config/config_backup/kitty
    cp -r ~/.config/alacritty ~/.config/config_backup/alacritty
    cp -r ~/.solutions/.editorconfig ~/solutions/.editorconfig_backup
    echo "finished backuing up personal setup"
fi


# ============== RESTORE ==============
if [ "$action" = "restore" ]; then
    echo "restoring dotfiles/shared to .config/ folders"
    rsync -a ~/solutions/dotfiles/shared/nvim/ ~/.config/nvim/
    rsync -a ~/solutions/dotfiles/shared/tmux/ ~/.config/tmux/
    rsync -a ~/solutions/dotfiles/shared/kitty/ ~/.config/kitty/
    rsync -a ~/solutions/dotfiles/shared/alacritty/ ~/.config/alacritty/
    rsync -a ~/solutions/dotfiles/shared/.editorconfig ~/solutions/
    echo "finished restoring personal setup"
    exit 0
fi

# ============== BACKUP ==============
if [ "$action" = "backup" ]; then
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

    echo "finished backing up shared .config/ folders"
    exit 0
fi
