{inputs, pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland
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
    hyprshot
    hyprlang
    hyprsunset
    hyprcursor
    rose-pine-hyprcursor
  ];
 
  programs.hyprlock.enable = true; 
  services.hypridle.enable = true;
  programs.waybar.enable = true;
}
