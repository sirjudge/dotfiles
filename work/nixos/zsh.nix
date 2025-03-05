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
            nixHome = "home-manager switch;hyprctl reload;waybar &";
            nixSystem = "sudo nixos-rebuild switch";
            nixUpdate = "sudo nix-channel --update; sudo nixos-rebuild switch; home-manager switch";
	    nixConfigEdit = "sudo nvim /etc/nixos/configuration.nix";
	    nixPackageUpdate = "sudo nvim /etc/nixos/packages.nix";
	    nixCdConfig = "cd /etc/nixos/";
	    nixCdHome = "cd /etc/nixos/";
	    

            # hyprland and bar
            hyprReload = "home-manager switch -b backup;hyprctl reload";
            waybarReload = "home-manager switch -b backup; hyprctl dispatch exec waybar";

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

            # set brightness commands
            lowBrightness="sudo brightnessctl --min-val=2 set 2%";
            maxBrightness="sudo brightnessctl --min-val=2 set 100%";

            # set monitor commands
            #officeMonitor="xrandr --output eDP-1-1 --auto --output DP-0 --primary --auto --left-of eDP-1-1;" ;
            #officeDualMonitors="~/Tools/scripts/DualOfficeMonitor.sh";
            #bedroomMonitor="xrandr --output eDP-1-1 --mode 1920x1080 --output HDMI-0 --primary --mode 1920x1080 --right-of eDP-1-1 ";

            # ZSH
            zshrc="nvim ~/.zshrc";
            reloadZsh="home-manager switch -b backup; /source ~/.zshrc";
            listAliases="cat ~/.zshrc | grep 'alias'";

            # directory shortcuts
            justAGuy="cd ~/solutions/just-a-little-guy/";
            sol="cd ~/solutions";
            homeConfig="cd ~/.config/home-manager/";
        };
        ohMyZsh = {
            enable = true;
            plugins = [ 
            "git" "aws" "battery" "dotenv" "emoji" "kubectl" "rust"
            ];
            theme = "fletcherm";
        };
    };
}

