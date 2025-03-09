{ pkgs, ... }:
{

  
  programs.hyprlock.enable = true; # enable Hyprland
  
  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
  
    # Whether to enable XWayland
    xwayland.enable = true;
  };

  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland
    
    # DE and bar
    hyprutils
    hyprpaper  
    xorg.xrandr
    mako
    wofi
    gtk3
    pango
    libxkbcommon
    wayland
    networkmanagerapplet
    cava
    wireplumber
    kitty
  ];



}
