{ config, pkgs, lib,... }:
{
# Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nico";
  home.homeDirectory = "/home/nico";

  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CONFIG_HOME = "/home/nico/.config/";
  };
  
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # load files after home manager has been loaded and initialized
  imports = [
    ./terminal/tmux.nix 
    ./terminal/kitty.nix
    ./git.nix
    ./wofi.nix
    ./hyprland/hyprland.nix
    ./waybar/waybar.nix
  ];
}
