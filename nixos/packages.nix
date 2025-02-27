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
    wget
    kdePackages.okular    

    # terminal
    zsh
    git
    kitty
   
    # Neovim and neovim accessories
    neovim

    # DE and bar
    xorg.xrandr
    mako
    wofi
    hyprpaper  
    gtk3
    pango
    hyprutils
    libxkbcommon
    wayland
    networkmanagerapplet
    cava
    wireplumber

    # CLI apps
    direnv
    texliveFull
    cachix
    ripgrep
    lynx
    ghostscript
    tectonic
    mermaid-cli
    fd
    imagemagick
    graph-easy
    slides
    loc
    
    # GPU Stuff
    seatd
   
    # dev libraries and langauges
    udev  
    alsa-lib
    vulkan-loader
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr 
    libxkbcommon
    wayland 
    alsa-lib.dev
    go
    pkg-config
    luarocks
    lua
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
    gnumake
  ];

  programs.firefox.enable = true;
  programs.waybar.enable = true;
  programs.hyprland.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}
