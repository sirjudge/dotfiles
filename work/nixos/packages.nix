{ pkgs, config, lib, ...}:
{

  # Explicitely allow dynamic link packages 
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages

  ];

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
    "aseprite"
  ];
    

  environment.systemPackages = with pkgs; [
    # awin stuff
    jdk
    maven
    awscli2
    aws-azure-login

    # getting virtual Box stuff to work
    glfw-wayland

    # Wine and wine accessories
    wineWowPackages.stable # support both 32-bit and 64-bit applications
    wine # support 32-bit only
    (wine.override { wineBuild = "wine64"; }) # support 64-bit only
    wine64 # support 64-bit only
    wineWowPackages.staging # wine-staging (version with experimental features)
    winetricks # winetricks (all versions)
    wineWowPackages.waylandFull # native wayland support (unstable)
    
    # hardware compatability
    thunderbolt
    solaar
    gnomeExtensions.solaar-extension

    # file
    xfce.thunar
    file
    zip
    unzip
    wget

    # terminal
    zsh
    git
    kitty
    ghostty
    neovim
    tmux
    fastfetch

    # DE and bar
    xorg.xrandr
    mako
    wofi
    hyprutils
    hyprpaper  
    gtk3
    pango
    libxkbcommon
    wayland
    networkmanagerapplet
    cava
    wireplumber

    # CLI apps
    docker
    direnv
    cachix
    ripgrep
    lynx
    ghostscript
    tectonic
    fd
    imagemagick
    fzf
    just
    ninja
    gcc
    cmake
    gnumake
    
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
    cairo
  ];

  programs.firefox.enable = true;
  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;
  };
}
