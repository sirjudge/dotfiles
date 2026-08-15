---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "fkeys:basic_13-24",
        kb_rules   = "",
        follow_mouse = 0,
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        touchpad = {
            natural_scroll = false,
            tap_to_click = true
        },
    },
      gestures = {
        workspace_swipe_distance = 700,
        workspace_swipe_cancel_ratio = 0.2,
        workspace_swipe_min_speed_to_force = 5,
        workspace_swipe_direction_lock = true,
        workspace_swipe_direction_lock_threshold = 10,
        workspace_swipe_create_new = true
    },
})

hl.gesture({
    fingers = 3,
    direction = "swipe",
    action = "move"
})
hl.gesture({
    fingers = 3,
    direction = "pinch",
    action = "fullscreen"
})
hl.gesture({
    fingers = 4,
    direction = "horizontal",
    action = "workspace"
})
hl.gesture({
    fingers = 4,
    direction = "up",
    action = function()
        hl.dispatch(hl.dsp.global("quickshell:overviewWorkspacesToggle"))
    end
})
hl.gesture({
    fingers = 4,
    direction = "down",
    action = function()
        hl.dispatch(hl.dsp.global("quickshell:overviewWorkspacesToggle"))
    end
})
-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
-- hl.device({
--     name        = "epic-mouse-v1",
--     sensitivity = -0.5,
-- })


local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local terminal = "ghostty"
local fileManager = "dolphin"
local menu = "fuzzel"


-- Quick launch
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

-- local closeWindowBind = 
hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)

-- hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- screenshot
hl.bind(mainMod .. " + S",  hl.dsp.exec_cmd("grimblast copysave area $HOME\"/Pictures/screenshots/area/\"$(date +'%F-%T.png'); hyprctl dispatch submap reset"))
-- binde = $mod, S, exec, 

-- bind = $mod, R, exec, $menu
-- bind = $mod, Q, exec, ghostty
-- bind = $mod, C, killactive
-- bind = $mod, space, togglefloating
-- bind = $mod, L, exec, hyprlock
-- bind = $mod, F, fullscreen
--

-- input {
--     kb_layout = us
--         follow_mouse = 0
--         kb_options = caps:escape
--         kb_options = fkeys:basic_13-24
--         touchpad {
--             natural_scroll = false
--                 tap-to-click = true
--         }
-- }
--
-- # Quickshell
-- bind = $mod, D, exec, ~/.config/scripts/quickshell-on-active-monitor.sh launcher 
-- bind = $mod, W, exec, ~/.config/scripts/quickshell-on-active-monitor.sh wallpaper 
-- bind = $mod SHIFT, W, exec, ~/.config/scripts/random-wallpaper.sh 
-- bind = $mod, A, exec, ~/.config/scripts/quickshell-on-active-monitor.sh dashboard 
-- bind = $mod, M, exec, ~/.config/scripts/quickshell-on-active-monitor.sh music
--
-- # bind = $mainMod, Q, exec, $terminal
-- # bind = $mainMod, C, killactive,
-- # bind = $mainMod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit
-- # bind = $mainMod, E, exec, $fileManager
-- # bind = $mainMod, V, togglefloating,
-- # bind = $mainMod, R, exec, $menu
--
-- bind = $mod, Left, movefocus, l
-- bind = $mod, Down, movefocus, d
-- bind = $mod, Up, movefocus, u
-- bind = $mod, Right, movefocus, r
--
-- bind = $mod , 1, workspace, 1
-- bind = $mod, 2, workspace, 2
-- bind = $mod, 3, workspace, 3
-- bind = $mod, 4, workspace, 4
-- bind = $mod, 5, workspace, 5
-- bind = $mod, 6, workspace, 6
-- bind = $mod, 7, workspace, 7
-- bind = $mod, 8, workspace, 8
-- bind = $mod, 9, workspace, 9
-- bind = $mod, 0, workspace, 0
--
-- bind = $mod SHIFT, 1, movetoworkspace, 1
-- bind = $mod SHIFT, 2, movetoworkspace, 2
-- bind = $mod SHIFT, 3, movetoworkspace, 3
-- bind = $mod SHIFT, 4, movetoworkspace, 4
-- bind = $mod SHIFT, 5, movetoworkspace, 5
-- bind = $mod SHIFT, 6, movetoworkspace, 6
-- bind = $mod SHIFT, 7, movetoworkspace, 7
-- bind = $mod SHIFT, 8, movetoworkspace, 8
-- bind = $mod SHIFT, 9, movetoworkspace, 9
-- bind = $mod SHIFT, 0, movetoworkspace, 0
--
-- bind = $mod, P, pseudo
-- # bind = $mod, J, togglesplit
--
-- bind = $mod, N, exec, swaync-client -t -sw
-- bind = $mod SHIFT, N, exec, swaync-client -C
--
-- bind = $mod, escape, submap, reset
--
-- bind = $mod, Menu, exec, ~/.config/scripts/define.sh
--
-- binde = $mod, F1, exec, amixer set Master toggle
-- binde = $mod, F2, exec, amixer set Master 1%-
-- binde = $mod, F3, exec, amixer set Master 1%+
-- binde = $mod, XF86AudioMute, exec, amixer set Master toggle
-- binde = $mod, XF86AudioLowerVolume, exec, amixer set Master 1%-
-- binde = $mod, XF86AudioRaiseVolume, exec, amixer set Master 1%+
