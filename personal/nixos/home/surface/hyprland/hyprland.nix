{ pkgs, inputs, config, ... }:
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

  home.file.".config/hypr/hyprland.conf".text = hyprlandConfig;
  home.file.".config/hypr/monitors.conf".text = monitorsConfig;
  home.file.".config/hypr/workspaces.conf".text = workspacesConfig;
  home.file.".config/hypr/rose-pine-moon.conf".text = rosePineMoonConfig;
  home.file.".config/hypr/keys.conf".text = hypr_keys;
  home.file.".config/hypr/window-rules.conf".text = window_rules;

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/Pictures/wallpapers/kikiCat.jpg"
        "~/Pictures/wallpapers/kirbyCup.webp"
        "~/Pictures/wallpapers/kittyRainbow.png"
        "~/Pictures/wallpapers/rosePineFunkyPattern.jpg"
      ];
      wallpaper = [
        "DP-6,~/Pictures/wallpapers/kittyRainbow.png"
        "DP-7,~/Pictures/wallpapers/rosePineFunkyPattern.jpg"
        "eDP-1,~/Pictures/wallpapers/kittyRainbow.png"
      ];
    };
  };
}
