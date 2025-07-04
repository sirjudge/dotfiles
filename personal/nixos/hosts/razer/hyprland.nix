 {inputs, pkgs, ...}: {
  environment.systemPackages = with pkgs; [
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
  programs.hyprland = {
    enable = true;
    # set the flake package
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;

  };

  programs.hyprlock.enable = true; 
  services.hypridle.enable = true;
  programs.waybar.enable = true;
                     }
