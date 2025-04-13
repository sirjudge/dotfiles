{ config, pkgs, lib,inputs,... }:
{
  # programs.home-manager.enable = true;
# Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "nico";
    homeDirectory = "/home/nico";
    sessionVariables = {
      EDITOR = "nvim";
      XDG_CONFIG_HOME = "/home/nico/.config/";
      GTK_USE_PORTAL = "1";
      NIXOS_OZONE_WL = "1";
      QT_SCALE_FACTOR = "1";
      __GR_VRR_ALLOWED = "0";
      __GR_GSYNC_ALLOWED = "0";
      BROWSER = "firefox";
      MOZ_ENABLE_WAYLAND = 1;  
    };
    
    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    };

    stateVersion = "24.11"; # Please read the comment before changing.
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # load files after home manager has been loaded and initialized
  imports = [
    ./terminal/tmux.nix 
    ./terminal/kitty.nix
    ./terminal/shell.nix
    ./git.nix
    ./wofi.nix
    ./hyprland/hyprland.nix
    ./waybar/waybar.nix
  ];

  gtk = {
	  enable = true;
	  # font.name = "Ubuntu Nerd Font";
	  font.name = "JetBrainsMono Nerd Font";
	  theme = {
		  # name = "Arc-Dark";
		  # package = pkgs.arc-theme;
		  name = "rose-pine";
		  package = pkgs.rose-pine-gtk-theme;
	  };
	  iconTheme = {
		  # name = "Arc";
		  # package = pkgs.arc-icon-theme;
		  name = "Rose pine icons";
		  package = pkgs.rose-pine-icon-theme;
	  };
  };

  qt.enable = true;
  qt.platformTheme.name = "qtct";
}
