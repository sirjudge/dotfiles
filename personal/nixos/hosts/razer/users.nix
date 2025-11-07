{ pkgs, lib, config, ... }:
{

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "claude-code"
  ];

  nixpkgs.config.allowUnfree = true;

  users.users.nico = {
    isNormalUser = true;
    description = "nico";
    extraGroups = [ "networkmanager" "wheel" "video" "seat" "docker" "vboxusers"];
    packages = with pkgs; [
      # Game stuff
      pokemmo-installer

      # yarr
      openvpn
      miru
      popcorntime

      # OS stuff
      caligula
      
      # Game Dev
      ldtk
      godot
      
      # DE stuff
      playerctl
      brightnessctl
      grim 
      slurp 
      grimblast
     
      # CLI
      gdb
      htop
      btop
      mermaid-cli
      texliveFull
      graph-easy
      slides
      nerdfetch  
      lshw
      pciutils
      usbutils
      pciutils
      pavucontrol
      krabby
      nerdfetch  
      pavucontrol
      fastfetch
      netcoredbg

      # IDES/AI 
      jetbrains.datagrip
      jetbrains.rust-rover
      jetbrains.idea-ultimate
      jetbrains.rider
      zed-editor

      # Pokemon themeing
      pokemonsay
      pokemon-cursor
      krabby
      

      #Misc Applications 
      kdePackages.okular    
      obsidian
      onlyoffice-bin
      autorandr
      wlogout
      bottles

      # Media
      qbittorrent
      lutris
      google-chrome
      vlc

      # Gamin
      heroic
      sunshine
      moonlight-qt
      prismlauncher

      #music
      bitwig-studio
      lmms
      qsynth

      # Jet brains
      
      # Art apps
      aseprite
      krita
      libresprite
      pixelorama
      gimp3-with-plugins
      darktable
    ];
  };

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  # Get Game Streaming To work real good
  security.wrappers.sunshine = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+p";
      source = "${pkgs.sunshine}/bin/sunshine";
  };
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 47984 47989 47990 48010 ];
  allowedUDPPortRanges = [
    { from = 47998; to = 48000; }
    #{ from = 8000; to = 8010; }
  ];
};

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

}

