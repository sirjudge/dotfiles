-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
--TODO: Need to take a second look at this, might want to just make my own quickshell
-- exec-once = ~/.local/bin/start-quickshell.sh
-- exec-once = swww-daemon
-- exec-once = wal -R -n
-- exec-once = swaync
-- exec-once = -- exec-once = pcmanfm -d 
-- Start up programs
hl.on("hyprland.start", function () 
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("mpd-mpris")
  hl.exec_cmd("kdeconnect-indicator")
  hl.exec_cmd("swaync")
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
  -- TODO: This might fix my instance not set issue
  -- hl.exec_cmd("hyprctl --instance 0 clients")
end)

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- cursor size and appearance of hyprland 
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- GPU and Wayland
hl.env("__GL_VRR_ALLOWED", "1")
hl.env("__GL_GSYNC_ALLOWED", "1")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("AQ_FORCE_LINEAR_BLIT", "0")

-- # Prefer the RTX 2060 as Hyprland's primary DRM device while still allowing the
-- # Intel iGPU for the internal eDP panel on this Optimus laptop. Use the stable
-- # PCI-based symlinks so docked boots do not depend on shifting cardN numbering.
-- # env = ,
-- hl.env("AQ_DRM_DEVICES", "/dev/dri/by-path/pci-0000:01:00.0-card:/dev/dri/by-path/pci-0000:00:02.0-card")
-- # Hybrid Intel + NVIDIA dock setup: prefer the documented Aquamarine multi-GPU
-- # blit workaround instead of the old wlroots-era modifier toggle.
-- hl.env("AQ_FORCE_LINEAR_BLIT", "0")

--TODO: need to investigate this
--https://wiki.hypr.land/Configuring/Advanced-and-Cool/Multi-GPU/
