-- Pull in the wezterm. API
local wezterm = require('wezterm')

-- Load configuration builder
local config = wezterm.config_builder()
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 15

local theme = wezterm.plugin.require('https://github.com/neapsix/wezterm').main
config.colors = theme.colors()
config.window_frame = theme.window_frame()

config.default_prog = { 'pwsh.exe' }

-- rebind to use tmux bindings
config.leader = { key = "b", mods = "CTRL" }  

-- Apply wezterm.tmux plugin with optional configuration
require("plugins.wez-tmux.plugin").apply_to_config(config, {
    -- Optional: Customize tab index base (0-based or 1-based)
    -- tab_and_split_indices_are_zero_based = true
})

-- create status bar 
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, 
{
    position = "bottom",
    max_width = 32,
    padding = {
        left = 1,
        right = 1,
        tabs = {
            left = 0,
            right = 2,
        },
    },
    separator = {
        space = 1,
        left_icon = wezterm.nerdfonts.fa_long_arrow_right,
        right_icon = wezterm.nerdfonts.fa_long_arrow_left,
        field_icon = wezterm.nerdfonts.indent_line,
    },
    modules = {
        tabs = {
            active_tab_fg = 4,
            inactive_tab_fg = 6,
            new_tab_fg = 2,
        },
        workspace = {
            enabled = true,
            icon = wezterm.nerdfonts.cod_window,
            color = 8,
        },
        leader = {
            enabled = true,
            icon = wezterm.nerdfonts.oct_rocket,
            color = 2,
        },
        zoom = {
            enabled = false,
            icon = wezterm.nerdfonts.md_fullscreen,
            color = 4,
        },
        pane = {
            enabled = true,
            icon = wezterm.nerdfonts.cod_multiple_windows,
            color = 7,
        },
        username = {
            enabled = true,
            icon = wezterm.nerdfonts.fa_user,
            color = 6,
        },
        hostname = {
            enabled = true,
            icon = wezterm.nerdfonts.cod_server,
            color = 8,
        },
        cwd = {
            enabled = true,
            icon = wezterm.nerdfonts.oct_file_directory,
            color = 7,
        },
    }
})

-- Finally, return the configuration to wezterm.:
return config
