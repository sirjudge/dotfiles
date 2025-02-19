{ config, pkgs, lib,... }:
{  
    # set zsh to the default shell and Prevent the new user dialog in zsh
    environment.shells = with pkgs; [ zsh];
    system.userActivationScripts.zshrc = "touch .zshrc";

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        histSize = 10000;
	enableLsColors = true;
        syntaxHighlighting.enable = true;
        shellInit = ''
	    # Set oh my zsh to auto update every 1 day
            zstyle ':omz:update' mode auto      
            zstyle ':omz:update' frequency 1

	    # set tmux to launch on zsh startup
            if [ -z "$TMUX" ]; then
                tmux attach -t default || tmux new -s default
	    fi

	'';
        shellAliases = {
            # nix
            nixReload = "sudo nixos-rebuild switch; home-manager switch";
            nixHome = "home-manager switch";
            nixSystem = "sudo nixos-rebuild switch";
            # Files and Folders
            mv="mv -v";
            ln="ln -v";
            cp="cp -v";
            rm="rm -v";
            ls="ls -a --group-directories-first --dereference-command-line-symlink-to-dir --color=auto";
            ll="ls --dereference-command-line-symlink-to-dir -lh";
            l="ls -la --dereference-command-line-symlink-to-dir";
            info="info --vi-keys --init-file=$XDG_CONFIG_HOME/infokey";
            pgrep="pgrep -l";
            grep="grep -i --color=auto";
            egrep="egrep --color=auto";
            ip="ip addr";
            # Tmux
            tmuxReload="tmux source  ~/.config/tmux/tmux.conf";
            tmuxNew="tmux new -s";
            tmuxAttach="tmux attach -t";
            tmuxList="tmux list-sessions";
            tmuxKill="tmux kill-session -t";

            # remap clear to cls because I am lazy
            cls="clear";

            # SSH commands
            homelab="ssh nico@192.168.1.34";

            # screenshotting
            screenshotSelect="scrot -s --file '/home/nico/Pictures/Screenshots/%Y-%m-%d_$wx$h_scrot.png'";

            # set brightness commands
            lowBrightness="sudo brightnessctl --min-val=2 set 2%";
            maxBrightness="sudo brightnessctl --min-val=2 set 100%";

            # set monitor commands
            officeMonitor="xrandr --output eDP-1-1 --auto --output DP-0 --primary --auto --left-of eDP-1-1;" ;
            officeDualMonitors="~/Tools/scripts/DualOfficeMonitor.sh";
            bedroomMonitor="xrandr --output eDP-1-1 --mode 1920x1080 --output HDMI-0 --primary --mode 1920x1080 --right-of eDP-1-1 ";

            # remap vim to nvim because I type both
            vim="nvim";

            # apt shortcuts
            upg="sudo apt-get update; sudo apt-get upgrade; sudo flatpak update";
            search="apt search";
            install="sudo apt install";

            # ZSH
            zshrc="nvim ~/.zshrc";
            reloadZsh="source ~/.zshrc";
            listAliases="cat ~/.zshrc | grep 'alias'";
            # directory shortcuts
            solutions="cd ~/solutions";
            sol="cd ~/solutions";
            configFolder="cd ~/.config";
            tools="cd ~/Tools";
        };
        ohMyZsh = {
            enable = true;
            plugins = [ "git" "aws" "battery" "dotenv" "emoji" "kubectl" "rust" ];
            theme = "fletcherm";
        };
    };
}

