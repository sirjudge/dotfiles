{ pkgs, lib, inputs, config, ... }:
let
  hyprlandConfig = builtins.readFile ./hyprland.conf;
  monitorsConfig = builtins.readFile ./monitors.conf;
  workspacesConfig = builtins.readFile ./workspaces.conf;
  rosePineMoonConfig = builtins.readFile ./rose-pine-moon.conf;
  hypr_keys = builtins.readFile ./keys.conf;
  window_rules = builtins.readFile ./window-rules.conf;
in
{
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true; # enable Hyprland
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
    ];
    extraConfig = ''
      ${rosePineMoonConfig}
      ${hyprlandConfig}
      ${monitorsConfig}
      ${workspacesConfig}
      ${hypr_keys}
      ${window_rules}
    '';
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/Pictures/wallpapers/kikiCat.jpg"
        "~/Pictures/wallpapers/kirbyCup.webp"
        "~/Pictures/wallpapers/kittyRainbow.png"
        "~/Pictures/wallpapers/rosePineFunkyPattern.jpg"
        "~/Pictures/wallpapers/hollow-knight.jpg"
      ];
      wallpaper = [
        "DP-3,~/Pictures/wallpapers/hollow-knight.jpg"
        "DP-4,~/Pictures/wallpapers/hollow-knight.jpg"
        "DP-5,~/Pictures/wallpapers/hollow-knight.jpg"
        "DP-6,~/Pictures/wallpapers/hollow-knight.jpg"
        "DP-7,~/Pictures/wallpapers/hollow-knight.jpg"
        "eDP-1,~/Pictures/wallpapers/hollow-knight.jpg"
      ];
    };
  };
}
