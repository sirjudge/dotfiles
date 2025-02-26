{pkgs, host, username, options, lib, inputs, system, ...}:

{
  imports = [ 
      ./hardware-configuration.nix
      ./packages.nix
      ./nvidia.nix
      ./zsh.nix
      ./fonts.nix
  ];

  # Bootloader.
  boot = {
    loader = {
        systemd-boot.enable = true;
	efi.canTouchEfiVariables = true;
    };
    blacklistedKernelModules = [
    	"dell_smbios"	
    ];
  };

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable flatpak because sometimes I just don't feel like using my braincells
  services.flatpak.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  #services.xserver.libinput.enable = true;

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


  # enable flake support
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
    AQ_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";		
  };

  # Install firefox.
  services.seatd.enable = true;

  # Shell 
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh];
  system.userActivationScripts.zshrc = "touch .zshrc";


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
 
  # Set up weekly garbage collection to keep bloat down
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  
  # Set some dconf options declaratively
  programs.dconf = {
    enable = true;
    profiles.user.databases = [ {
      settings = with lib.gvariant; {
        # Don't show a welcome dialog
        "org/gnome/shell" = {
          welcome-dialog-last-shown-version = "9999999999";
        };
        # No timeouts
        "org/gnome/desktop/session" = {
          idle-delay = mkUint32 0;
        };
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-ac-type = "nothing";
          sleep-inactive-battery-type = "nothing";
        };

        # Faster key repeat
        "org/gnome/desktop/peripherals/keyboard" = {
          delay = mkUint32 200;
          repeat-interval = mkUint32 25;
        };

        # Bigger default console font size
        "org/gnome/Console" = {
          font-scale = 2.0;
        };
      };
    } ];
  };
}
