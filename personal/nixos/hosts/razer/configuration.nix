{pkgs, config, host, username, options, lib, inputs, system, ...}:
{
  imports = [ 
      ./hardware-configuration.nix
      ./boot.nix
      ./gnome.nix
      ./packages.nix
      ./gpu.nix
      ./terminal.nix
      ./users.nix
      ./docker.nix
      ./audio.nix
      ./bluetooth.nix
      ./vpn.nix
      ./hyprland.nix
      inputs.ssbm-nix.overlay 
      ./discord.nix
  ];

  # set up printing auto find
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
   
  services.printing = {
    enable = true;
    drivers = [ pkgs.cnijfilter2 ];
  };



  # Set up dolphin udev rules to get controller working
  services.udev.packages = [ pkgs.dolphin-emu ];

  # built slippi and hyprcursor
  environment.systemPackages = [
    # inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    inputs.zen-browser.packages.${pkgs.system}.default
    pkgs.slippi-launcher 
  ];

  # Enable AppImage support
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
    magicOrExtension = "\\x7fELF....AI\\x02";
  };

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

  networking = {
    hostName = "nico";
    networkmanager.enable = true;
  };

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
  
  # Enable flatpak because sometimes I just don't feel 
  # like using my braincells
  services.flatpak.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
  };


  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # multi-touch gesture recognizer
  services.touchegg.enable = true;

  # enable flake support
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.sessionVariables = rec {
    # get electron on wayland
    NIXOS_OZONE_WL = "1";

    # Dotnet stuff
    # DOTNET_ROOT = "/nix/store/3sq3xhyww1189623wf083rz58yki8fj3-system-path/bin/dotnet";
    DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet/";

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
    dates = "daily";
    options = "--delete-older-than 2d";
  };
  
}
