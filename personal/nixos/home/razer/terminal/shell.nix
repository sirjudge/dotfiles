{config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    pkgs.oh-my-zsh
  ];
  
  # starship
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[›](bold green)";
        error_symbol = "[›](bold red)";
      };

      git_status = {
        deleted = "✗";
        modified = "✶";
        staged = "✓";
        stashed = "≡";
      };

      nix_shell = {
        symbol = " ";
        heuristic = true;
      };
    };
  };

# Zoxide
  programs.zoxide.enable = true;

# Zsh
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    autocd = true;
    dirHashes = {
      dl = "$HOME/Downloads";
      docs = "$HOME/Documents";
      sol = "$HOME/solutions";
      dots = "$HOME/solutiosn/dotfiles";
      pics = "$HOME/Pictures";
      vids = "$HOME/Videos";
      nixcfg = "/etc/nixos";
    };
    dotDir = ".config/zsh";
    history = {
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh_history";
    };

# shellInit = ''
    initContent = ''
      # Set oh my zsh to auto update every 1 day
      zstyle ':omz:update' mode auto      
      zstyle ':omz:update' frequency 1

      # set tmux to launch on zsh startup
      if [ -z "$TMUX" ]; then
        tmux attach -t default || tmux new -s default
      fi

      source ~/.config/zsh/rose-pine-zsh/rose-pine-zsh.zsh
      colorize_zsh rose-pine


      
      # Load .net tool path
      export PATH="$PATH:/home/nico/.dotnet/tools"
    '';


    shellAliases =
    {
      nixBackup = "/home/nico/solutions/dotfiles/backup.sh -b -p";
      nixSwitch = "sudo nixos-rebuild switch;";
      nixUpdate = "sudo nix-channel --update; sudo nixos-rebuild switch";
      nixConfigEdit = "sudo nvim /etc/nixos/configuration.nix";
      nixPackageUpdate = "sudo nvim /etc/nixos/packages.nix";
      nixCdConfig = "cd /etc/nixos/";

      # hyprland and bar
      hyprReload = "hyprctl reload";

      # fast fetch with cosmog
      ff="krabby name cosmog | fastfetch --file-raw -";

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

      # ZSH
      editTerminalSettings="nvim /etc/nixos/terminal.nix";
      listAliases="cat ~/.zshrc | grep 'alias'";

      # logout 
      lo="wlogout --protocol layer-shell";

      # directory shortcuts
      justAGuy="cd ~/solutions/just-a-little-guy/";
      sol="cd ~/solutions";
      homeConfig="cd ~/.config/home-manager/";
    };

# lib.optionalAttrs config.programs.bat.enable {cat = "bat";};
    shellGlobalAliases = {eza = "eza --icons --git";};
  };

}
