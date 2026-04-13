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

-- Startup layout: 3 tabs with preset pane splits and working directories
wezterm.on('gui-startup', function(cmd)
    local home = wezterm.home_dir
    local v3api = home .. '/solutions/v3.api'
    local ui    = home .. '/solutions/UI'
    local auth  = home .. '/solutions/Authorization'

    -- Tab 1: single pane at v3.api
    local tab1, pane1, window = wezterm.mux.spawn_window { cwd = v3api, workspace = 'API' }
    pane1:send_text('nvim')

    -- Tab 2: single pane at UI
    local tab2, pane2 = window:spawn_tab { cwd = ui, workspace = 'UI' }
    pane2:send_text('nvim')


    -- Tab 3: 3 columns
    local tab3, col1 = window:spawn_tab { cwd = v3api, workspace = { 'Terminal' } }
    -- Split col1 to the right → col2 (Authorization)
    local col2 = col1:split { direction = 'Right', cwd = auth }
    col2:send_text('runApi')
    -- Split col2 to the right → col3-top (UI)
    local col3_top = col2:split { direction = 'Right', cwd = ui }
    col3_top:send_text('npm run start')
    -- Split col3-top downward → col3-bottom (UI)
    local col3_bot = col3_top:split { direction = 'Bottom', cwd = ui }
    col3_bot:send_text('npm run serve-tools')

    -- Start on Tab 1
    tab1:activate()
end)

-- Finally, return the configuration to wezterm.:
return config
