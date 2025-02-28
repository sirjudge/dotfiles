{ pkgs, lib, config, ... }:
{
  users.users.nico = {
    isNormalUser = true;
    description = "nico";
    extraGroups = [ "networkmanager" "wheel" "video" "seat"];
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
	usbutils
	htop-vim
	lshw
	pciutils
	pavucontrol
	krabby
	nerdfetch  
        usbutils
	htop-vim
	lshw
	pciutils
	pavucontrol
	# Applications 
	kdePackages.okular    
	obsidian
	onlyoffice-bin
	discord-ptb
	autorandr
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

}





