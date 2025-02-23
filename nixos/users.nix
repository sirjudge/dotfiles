
  # Define a user account. Don't forget to set a password with ‘passwd’.
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
	nerdfetch  
	usbutils
	htop-vim
	lshw
	pciutils
	pavucontrol
	# Applications 
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
    ];
  };

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };


