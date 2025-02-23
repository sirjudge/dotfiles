{ pkgs, config, lib, ...}:
{
# Allow certain non-free open source services
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
    "discord-ptb"
    "discord"
    "nvidia-x11"
    "nvidia-settings"
    "cuda_cudart"
    "libcublas"
    "cuda_cccl"
    "cuda_nvcc"
    "google-chrome"
    "obsidian"
    "datagrip"
    "rust-rover"
    "idea-ultimate"
  ];

  environment.systemPackages = with pkgs; [
    # hardware compatability
    thunderbolt
    # file
    xfce.thunar
    file
    zip
    unzip
    # CLI apps
    ripgrep
    wget
    zsh
    git
    kitty
    neovim
    # GPU Stuff
    seatd
    # DE
    xorg.xrandr
    mako
    wofi
    hyprpaper  
    gtk3
    pango
    hyprutils
    libxkbcommon
    wayland
    # bar
    networkmanagerapplet
    cava
    wireplumber
    # dev libraries and langauges
    pkg-config
    luarocks
    luajit
    nodejs_22 
    rustup
    nwg-displays
    pkg-config
    udev
    clang
    lld
    gcc
    cmake
    ninja
    cairo
  ];

  programs.firefox.enable = true;
  programs.waybar.enable = true;
  programs.hyprland.enable = true;
}
