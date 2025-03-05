{pkgs,lib,...}:
{
    programs.kitty = lib.mkForce {
        enable = true;
        extraConfig = (''
# name: Rosé Pine Moon
# author: mvllow
# license: MIT
# upstream: https://github.com/rose-pine/kitty/blob/main/dist/rose-pine-moon.conf
# blurb: All natural pine, faux fur and a bit of soho vibes for the classy minimalist

    foreground               #e0def4
    background               #232136
    selection_foreground     #e0def4
    selection_background     #44415a

    cursor                   #56526e
    cursor_text_color        #e0def4
    url_color                #c4a7e7

    active_tab_foreground    #e0def4
    active_tab_background    #393552
    inactive_tab_foreground  #6e6a86
    inactive_tab_background  #232136

    active_border_color      #3e8fb0
    inactive_border_color    #44415a

# black
                color0   #393552
                color8   #6e6a86

# red
                color1   #eb6f92
                color9   #eb6f92

# green
                color2   #3e8fb0
                color10  #3e8fb0

# yellow
                color3   #f6c177
                color11  #f6c177

# blue
                color4   #9ccfd8
                color12  #9ccfd8

# magenta
                color5   #c4a7e7
                color13  #c4a7e7

# cyan
                color6   #ea9a97
                color14  #ea9a97

# white
                color7   #e0def4
                color15  #e0def4


# Colorscheme and look
                tab_bar_style powerline

# minimize latency per documentation
# Turn off terminal bell
visual_bell_duration 0.0
sync_to_monitor yes

# Font and Font accessories
#font_family      JetBrainsMono Nerd Font Mono
#bold_font        JetBrainsMono Nerd Font Mono Extra Bold
#bold_italic_font JetBrainsMono Nerd Font Mono Extra Bold Italic

# turn remote control off explicitly (no ssh or application control)

# set update interval to every 24 hours
update_check_interval 24

# enable shell integration for richer interactions
#shell_integration enabled

# Get notified of a finsihed command if the window is not focused
notify_on_cmd_finish unfocused

# Keymaps
# https://sw.kovidgoyal.net/kitty/conf/#keyboard-shortcuts
# kitty_mod
                kitty_mod ctrl+shift

                hide_window_decorations no
                '');
        settings = {
            confirm_os_window_close = 0;
            dynamic_background_opacity = true;
            enable_audio_bell = false;
            allow_remote_control = false;
            mouse_hide_wait = "-1.0";
            window_padding_width = 10;
            background_opacity = "0.9";
            background_blur = 5;
            input_delay = 3;
            repaint_delay = 2;
            symbol_map = let
                mappings = [
                "U+23FB-U+23FE"
                    "U+2B58"
                    "U+E200-U+E2A9"
                    "U+E0A0-U+E0A3"
                    "U+E0B0-U+E0BF"
                    "U+E0C0-U+E0C8"
                    "U+E0CC-U+E0CF"
                    "U+E0D0-U+E0D2"
                    "U+E0D4"
                    "U+E700-U+E7C5"
                    "U+F000-U+F2E0"
                    "U+2665"
                    "U+26A1"
                    "U+F400-U+F4A8"
                    "U+F67C"
                    "U+E000-U+E00A"
                    "U+F300-U+F313"
                    "U+E5FA-U+E62B"
                ];
            in
                (builtins.concatStringsSep "," mappings) + " Symbols Nerd Font";
        };
    };
}
