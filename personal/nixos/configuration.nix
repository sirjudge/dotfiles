{pkgs, host, username, options, lib, inputs, system, ...}:

{
  imports = [ 
      ./hardware-configuration.nix
      ./packages.nix
      ./gpu.nix
      ./terminal.nix
      ./fonts.nix
      ./users.nix
      ./docker.nix
      ./audio.nix
      ./bluetooth.nix
      ./hyprland/hyprland.nix
  ];

  # Bootloader.
  boot = {
    loader = {
        systemd-boot.enable = true;
	efi.canTouchEfiVariables = true;
    };

    #TODO: gonna uncomment this out, wonder if it'll fix anything magically. . . would be nice
    # causes weird issues with not recognizing the dock on start up
    blacklistedKernelModules = [
    	"dell_smbios"	
    ];
    
    kernelParams = [ "psmouse.synaptics_intertouch=0" ];
    kernelModules = ["evdi" "udl" ];
  };

  networking.hostName = "nixos"; # Define your hostname.

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
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
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

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # multi-touch gesture recognizer
  services.touchegg.enable = true;

  # enable flake support
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.sessionVariables = rec {
   # get electron on wayland
    NIXOS_OZONE_WL = "1";

    # Ensure XDG paths and variables are set
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
   
    # GPU driver nonsense
    # Use the following to idenntify card
    #AQ_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";		
    AQ_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";		
    LIBVA_DRIVER_NAME="nvidia";
    WLR_DRM_NO_MODIFIERS="1";
    GBM_BACKEND="nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME="nvidia";

    # Wayland specifications for other random nonsense
    #XDG_CURRENT_DESKTOP="Hyprland";
    #XDG_SESSION_TYPE="wayland";
    #XDG_SESSION_DESKTOP="Hyprland";
    # GDK_BACKEND="wayland,x11,*";
    #QT_QPA_PLATFORM="wayland;xcb";
    # SDL_VIDEODRIVER="wayland";
 
    # Screenshot
    # HYPRSHOT_DIR="/home/nico/Pictures/Screenshots";
  };

  services.seatd.enable = true;

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
