{ pkgs, lib, config, ... }:
{
  users.users.nico = {
    isNormalUser = true;
    description = "nico";
    extraGroups = [ "networkmanager" "wheel" "video" "seat" "docker"];
    packages = with pkgs; [
      # DE stuff
      playerctl
      brightnessctl
      grim 
      slurp 
      grimblast
     
      # CLI
      mermaid-cli
      texliveFull
      graph-easy
      slides
      loc
      nerdfetch  
      htop-vim
      lshw
      pciutils
      usbutils
      htop-vim
      pciutils
      pavucontrol
      krabby
      nerdfetch  
      pavucontrol
      
      #Misc Applications 
      kdePackages.okular    
      obsidian
      onlyoffice-bin
      discord-ptb
      autorandr
      wlogout
     
      # Media
      qbittorrent
      lutris
      heroic
      google-chrome
      
      # Jet brains
      jetbrains.datagrip
      jetbrains.rust-rover
      jetbrains.idea-ultimate
      
      # Art apps
      aseprite
      krita
      libresprite
      pixelorama
    ];
  };

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
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






