
{ config, pkgs, lib, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}

    /*
     * Variant: Rosé Pine Moon
     * Maintainer: DankChoir
     */

    @define-color base            #232136;
    @define-color surface         #2a273f;
    @define-color overlay         #393552;

    @define-color muted           #6e6a86;
    @define-color subtle          #908caa;
    @define-color text            #e0def4;

    @define-color love            #eb6f92;
    @define-color gold            #f6c177;
    @define-color rose            #ea9a97;
    @define-color pine            #3e8fb0;
    @define-color foam            #9ccfd8;
    @define-color iris            #c4a7e7;

    @define-color highlightLow    #2a283e;
    @define-color highlightMed    #44415a;
    @define-color highlightHigh   #56526e;

    * {
      font-size: 18px;
    }
    window#waybar {
      background-color: @base;
      padding-top: 5px;
      border-bottom: 2px solid @highlightLow;
      border-top: 2px solid @highlightLow;
      padding-top: 5px;
      color: @text;
      transition-property: background-color;
      transition-duration: .5s;
    }

  #workspaces button.focused {
    background: rgba(0, 0, 0, 0.2);
    border-top: 3px solid @highlightLow;
    border-bottom: 3px solid @highlightLow;
    border-left: 2px dashed @highlightLow;
    border-right: 2px dashed @highlightLow;
    color: #9730fd;
  }

#workspaces button.urgent {
    background-color: #eb4d4b;
}


#tray {
    padding-left: 8px;
    padding-right:8px;
    min-width: 40px;
    border-left: 2px dashed @;
    font-size: 20px;
}


#workspaces button {
    padding-left: 10px;
    padding-right: 10px;
    /*padding-top: 5px;
    padding-bottom: 5px;*/

    background-color: transparent;
    color: inherit;
    font-weight: 600;
    border-top: 4px solid transparent;
    border-bottom: 3px solid transparent;
    border-left: 2px dashed #a678d3;

}

#workspaces button:first-child {
    border-left: 0;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
#workspaces button:hover {
    background: rgba(0, 0, 0, 0.2);
    box-shadow: inherit;
    text-shadow: inherit;
    border-bottom: 3px solid @highlightLow;
    border-top: 3px solid @highlightLow; 
}

#mpd, #pulseaudio, #network, #cpu, #memory, #temperature, #clock, #window {
    padding-left: 8px;
    padding-right: 8px;
    /*
    padding-top: 5px;
    padding-bottom: 5px;
    */

    background-color: @base;
    color: inherit;
    font-weight: 600;
    border-top: 4px solid transparent;
    border-bottom: 3px solid transparent;
    border-left: 2px dashed #a678d3;
}

#window {
    min-width: 500px;
}

#clock {
    font-size: 14px;
}

    '';
    settings = [{
      height = 30;
      layer = "top";
      position = "bottom";
      tray = { spacing = 10; };
      modules-center = [ "hyprland/window" ];
      modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "battery" 
        "clock"
        "tray"
      ];
      battery = {
        format = "{capacity}% {icon}";
        format-alt = "{time} {icon}";
        format-charging = "{capacity}% ";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = "{capacity}% ";
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
        format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
        format-linked = "{ifname} (No IP) ";
        format-wifi = "{essid} ({signalStrength}%) ";
      };
      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-icons = {
          car = "";
          default = [ "" "" "" ];
          handsfree = "";
          headphones = "";
          headset = "";
          phone = "";
          portable = "";
        };
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        on-click = "pavucontrol";
      };
      "hyprland/mode" = { format = ''<span style="italic">{}</span>''; };
      temperature = {
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [ "" "" "" ];
      };
    }];
  };
}
