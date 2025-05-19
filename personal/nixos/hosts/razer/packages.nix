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
    # Gamin and Graphics
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
    # Allow nvidia closed source drivers
    "nvidia-x11"
    "nvidia-settings"
    "cuda_cudart"
    "libcublas"
    "cuda_cccl"
    "cuda_nvcc"
    # Web + Social
    "discord-ptb"
    "discord"
    "google-chrome"
    # IDE/Dev
    "obsidian"
    "datagrip"
    "rust-rover"
    "idea-ultimate"
    # Media + Art
    "aseprite"
    "keymapp"
    "bitwig-studio-unwrapped"
    "cursor"
  ];


  environment.systemPackages = with pkgs; [
    # Nix
    nix-search
    nix-search-cli

    # Get qt support for wayland
    # Note: Bit unstable at the moment
    # qtwayland
    kdePackages.qtwayland
    libsForQt5.qt5.qtwayland

    # gtk and themeing
    lxappearance

    # get app images working
    appimage-run

    # Audio 
    alsa-utils
  
    # offline ergodox Keyboard mapper
    keymapp

    # Terminal -> File applications
    yazi
    ranger
    _7zz
    w3m
    xfce.thunar
    file
    zip
    unzip
    wget
    tdf
    ghostscript
    ripgrep
    fd
    fzf

    # Terminal -> Kitty Image protocol magic
    imagemagick
    libcaca
    highlight

    # Terminal -> Shell and Emulator
    zsh
    ghostty

    # Terminal IDE
    neovim
    git
    docker
    direnv
    cachix
    tokei
    code-cursor

    # Terminal -> Build and compile
    lynx
    tectonic
    just
    ninja
    gcc
    cmake
    gnumake
    seatd
    udev  
    go
    pkg-config
    luarocks
    lua
    luajit
    nodejs_22 
    rustup
    pkg-config
    udev
    clang
    lld
    cairo

    # Desktop Environment + Display
    nwg-displays
    vulkan-loader
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr 
    libxkbcommon
    wayland 
   
    
    # Audio
    alsa-lib
    alsa-lib.dev
    ffmpeg-full
    mpv 

    # Font and font accessories
    poppler_utils
    calibre
    fontforge
  
    # Godot and dotnet/mono

    godot_4
    godot_4-mono
    godot-mono
    dotnetCorePackages.sdk_9_0_1xx-bin
    blender

    # Database
    sqlite-utils
    sqlite
	
    # Support all the wine, why not
    wineWowPackages.stable
    wine
    (wine.override { wineBuild = "wine64"; })
    wine64
    wineWowPackages.staging
    winetricks
    wineWowPackages.waylandFull
    
    # hardware compatability
    thunderbolt
    solaar
    # gnomeExtensions.solaar-extension
    pamixer # Command-line mixer for PulseAudio
    bluez # Bluetooth support
    bluez-tools # Bluetooth tools
   
    # Java
    maven
    jdt-language-server
    jdk

    # lua
    lua
    lua-language-server
  ];

  programs.firefox.enable = true;
}
