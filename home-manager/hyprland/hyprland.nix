{ pkgs, ... }:
let
  hyprlandConfig = builtins.readFile ./hyprland.conf;
  monitorsConfig = builtins.readFile ./monitors.conf;
  workspacesConfig = builtins.readFile ./workspaces.conf;
  rosePineMoonConfig = builtins.readFile ./rose-pine-moon.conf;
in
{
  #home.stateVersion = "23.05"; # or the appropriate version for your setup
  home.file.".config/hypr/hyprland.conf".text = hyprlandConfig;
  home.file.".config/hypr/monitors.conf".text = monitorsConfig;
  home.file.".config/hypr/workspaces.conf".text = workspacesConfig;
  home.file.".config/hypr/rose-pine-moon.conf".text = rosePineMoonConfig;
}
