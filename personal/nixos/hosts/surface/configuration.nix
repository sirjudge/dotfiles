{inputs, hardware, config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./surface.nix
      ./vpn.nix
      ./hyprland.nix
      ./docker.nix
      ./terminal.nix
    ];

  # Enable flakes and nix-commands
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
 

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
  services.libinput.enable = true;

  # multi-touch gesture recognizer
  services.touchegg.enable = true;


 nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
   "obsidian"
   "discord-ptb"
   "steam"
   "steam-unwrapped"
   "google-chrome"
   "datagrip"
   "rust-rover"
   "idea-ultimate"
   "aseprite"
   "cursor"
 ];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nico = {
    isNormalUser = true;
    description = "Nico";
    extraGroups = [ "networkmanager" "wheel" "networkmanager" "surface-control" ];
    packages = with pkgs; [
      # DE stuff
      hyprland
      # CLI
      playerctl
      grim 
      slurp 
      grimblast
      git 
      mermaid-cli
      texliveFull
      graph-easy
      slides
      nerdfetch  
      krabby
      fastfetch  
      tokei
      usbutils
      htop-vim
      lshw
# Applications 
      kdePackages.kate
      ghostty
      kitty
      neovim
      code-cursor
      kdePackages.okular    
      obsidian
      onlyoffice-bin
      discord-ptb
# Media
      qbittorrent
      lutris
      heroic
      google-chrome
# Art apps
      aseprite
      krita
      libresprite
      pixelorama
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Set up dolphin udev rules to get controller working
  services.udev.packages = [ pkgs.dolphin-emu ];

  # app image stuff
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # Slippi
  programs.appimage.package = pkgs.appimage-run.override {
    extraPkgs = pkgs: [
      pkgs.curl
      pkgs.libmpg123
    ];
  };

  # keyboard 
  hardware.keyboard.zsa.enable = true;

  fonts.packages  = [
    pkgs.nerd-fonts._0xproto
    pkgs.nerd-fonts.droid-sans-mono
    pkgs.nerd-fonts.jetbrains-mono
  ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    # pkgs.slippi-launcher 
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    iptsd
    autorandr
    brightnessctl
    usbutils
    htop-vim
    lshw
    pciutils
    pavucontrol
  ];

  environment.sessionVariables = rec {
   # get electron on wayland
    NIXOS_OZONE_WL = "1";

    # Ensure XDG paths and variables are set
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
 
    # Screenshot
    HYPRSHOT_DIR="/home/nico/Pictures/Screenshots";
  };

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
}
