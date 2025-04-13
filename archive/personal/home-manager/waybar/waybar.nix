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
        output = ["DP-6"];
        height = 30;
        layer = "top";
        position = "bottom";
        tray = { spacing = 10; };
        modules-center = [
          "hyprland/workspaces" "hyprland/submap"
        ];
        modules-left = [
         "tray" "privacy" "hyprland/window"   
        ];
        modules-right = [
          "pulseaudio" "network" "cpu" "memory" "temperature" "battery" "clock"
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
          format-ethernet = "{ifname}: {ipaddr}/{cidr} 󰈀  up: {bandwidthUpBits} down: {bandwidthDownBits}";
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
    {
      output = ["DP-7"];
      height = 30;
      layer = "top";
      position = "bottom";
      tray = { spacing = 10; };
      modules-center = [
        "hyprland/workspaces" "hyprland/submap"
      ];
      modules-left = [
        "tray" "privacy" "hyprland/window"   
      ];
    }
    {
      output = ["eDP-1"];
      height = 30;
      layer = "top";
      position = "bottom";
      tray = { spacing = 10; };
      modules-center = [
        "hyprland/workspaces" "hyprland/submap"
      ];
      modules-left = [
        "tray" "privacy" "hyprland/window"   
      ];
    }
    {
      output = ["DP-3"];
      height = 30;
      layer = "top";
      position = "bottom";
      tray = { spacing = 10; };
      modules-center = [
        "hyprland/workspaces" "hyprland/submap"
      ];
      modules-left = [
        "tray" "privacy" "hyprland/window"   
      ];
    }
    ];
  };
}
