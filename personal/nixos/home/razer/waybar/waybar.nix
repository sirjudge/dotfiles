{ config, pkgs, lib, ... }:
let 
  waybar_style = builtins.readFile ./style.css;
in
{

programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = waybar_style;
    settings = 
      [
      {
        output = [
        "eDP-1"
        "DP-4"
        "DP-5"
        "DP-6"
        "DP-7"
        "DP-8"
        "HDMI-A-1"
        ];
        height = 30;
        layer = "top";
        position = "bottom";
        tray = { spacing = 10; };
        modules-center = [
          # "hyprland/workspaces" "hyprland/submap"
          "hyprland/workspaces" #"hyprland/submap"
        ];
        modules-left = [
         "custom/power" "tray"   
        ];
        modules-right = [
          "pulseaudio" "network" "cpu" "memory" "clock"
        ];
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        battery = {
          format = "{capacity}% {icon}";
          format-alt = "{time} {icon}";
          format-charging = "{capacity}% ";
          format-icons = [ "" "" "" "" "" ];
          format-plugged = "{capacity}%  ";
          states = {
            critical = 15;
            warning = 30;
          };
        };
        clock = {
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        memory = { format = "{}% "; };
        network = {
          interval = 1;
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          format-disconnected = "Disconnected ⚠";
          format-ethernet = "{ifname}:󰈀 ";
          format-linked = "{ifname} (No IP) 󰤭 ";
          format-wifi = "{essid} ({signalStrength}%)  ";
        };
        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-icons = {
            car = " ";
            default = [ "" " " " " ];
            handsfree = " ";
            headphones = " ";
            headset = " ";
            phone = " ";
            portable = " ";
          };
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          on-click = "pavucontrol";
        };
        "hyprland/submap" = { 
          format = ''<span style="italic">{}</span>''; 
        };
        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [ "" "" "" ];
        };
        "custom/power" = {
          format = " ⏻ ";
          on-click= "wlogout --protocol layer-shell";
        };
    }
    ];
  };
}
