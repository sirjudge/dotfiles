-- Pull in the wezterm. API
local wezterm = require("wezterm")

-- Load configuration builder
local config = wezterm.config_builder()
config.font = wezterm.font("JetBrains Mono")
config.font_size = 15

local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main
config.colors = theme.colors()
config.window_frame = theme.window_frame()

config.default_prog = { "pwsh.exe" }

local act = wezterm.action
config.disable_default_key_bindings = true;
config.leader = { key = "b", mods = "CTRL" }
config.keys = {
    {
        key = '!',
        mods = 'CTRL|SHIFT',
        action = act.SwitchToWorkspace {
            name = 'Editor'
        }

    },
    {
        key = '@',
        mods = 'CTRL|SHIFT',
        action = act.SwitchToWorkspace {
            name = 'Terminal'
        }
    },
    {
        key = '#',
        mods = 'CTRL|SHIFT',
        action = act.SwitchToWorkspace {
            name = 'Scratch'
        }
    },

    -- Clipboard
    { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo('Clipboard') },
    { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom('Clipboard') },

    -- Font size
    { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
    { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
    { key = '0', mods = 'CTRL', action = act.ResetFontSize },

    -- Scroll
    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },

    -- Search
    { key = 'f', mods = 'CTRL|SHIFT', action = act.Search({ CaseSensitiveString = '' }) },

    -- Utilities
    { key = 'r', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },
    { key = 'l', mods = 'CTRL|SHIFT', action = act.ShowDebugOverlay },
    { key = 'p', mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette },
    { key = 'u', mods = 'CTRL|SHIFT', action = act.CharSelect },
    { key = 'k', mods = 'CTRL|SHIFT', action = act.ClearScrollback('ScrollbackOnly') },

    -- Fullscreen
    { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },
}

for i = 1, 8 do
  -- CTRL+SHIFT + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL',
    action = act.ActivateTab(i - 1),
  })
end

-- Apply wezterm.tmux plugin with optional configuration
require("plugins.wez-tmux.plugin").apply_to_config(config, {
	-- Optional: Customize tab index base (0-based or 1-based)
	-- tab_and_split_indices_are_zero_based = true
})

-- create status bar
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, {
	position = "bottom",
	max_width = 32,
	padding = {
		left = 1,
		right = 1,
		tabs = {
			left = 0.5,
			right = 0.5,
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
			enabled = false,
			icon = wezterm.nerdfonts.fa_user,
			color = 6,
		},
		hostname = {
			enabled = false,
			icon = wezterm.nerdfonts.cod_server,
			color = 8,
		},
		cwd = {
			enabled = true,
			icon = wezterm.nerdfonts.oct_file_directory,
			color = 7,
		},
	},
})

-- Startup layout: 3 tabs with preset pane splits and working directories
wezterm.on("gui-startup", function(cmd)
	local home = wezterm.home_dir
	local api = home .. "/solutions/v3.api"
	local ui = home .. "/solutions/UI"
	local auth = home .. "/solutions/Authorization"

	-- Window 1 has UI and API tabs
	local _, _, window = wezterm.mux.spawn_window({ cwd = api, workspace = "Editor", args = { "nvim" } })

	local _, _ = window:spawn_tab({ cwd = ui, args = { "nvim" } })

	-- window 2 has terminal stuff
	local termTab, termPane, termWindow = wezterm.mux.spawn_window({ cwd = api, workspace = "Terminal" })
	termPane:send_text("runApi")

	local authPane = termPane:split({
		direction = "Right",
		cwd = auth,
	})
	authPane:send_text("runAuth")

	local uiTab, uiPane = termWindow:spawn_tab({ cwd = ui })
	uiPane:send_text("npm run start")

    local implPane = uiPane:split({
		direction = "Right",
		cwd = ui,
	})
	implPane:send_text("npm run serve-tools")

     
	local scratchTab, scratchPane, scratchWindow = wezterm.mux.spawn_window({ cwd = "~/", workspace = "Scratch" })
end)

return config
