-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- Load configuration builder
local config = wezterm.config_builder()

-- For example, changing the initial geometry for new windows:
--config.initial_cols = 120
--config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 15

-- load the rose pine theme colors instead of using a colorscheme
local theme = wezterm.plugin.require('https://github.com/neapsix/wezterm').main

config.colors = theme.colors()
config.window_frame = theme.window_frame()

config.default_prog = { 'pwsh.exe' }

-- rebind to use tmux bindings
config.leader = { key = "b", mods = "CTRL" }  

-- Apply wez-tmux plugin with optional configuration
require("plugins.wez-tmux.plugin").apply_to_config(config, {
    -- Optional: Customize tab index base (0-based or 1-based)
    -- tab_and_split_indices_are_zero_based = true
})

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config)

-- Finally, return the configuration to wezterm:
return config
