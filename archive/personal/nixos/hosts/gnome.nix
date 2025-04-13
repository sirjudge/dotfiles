{ pkgs,lib, config, ...} :
{

  # Enable the GNOME Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # environment.gnome.excludePackages = (with pkgs; [
  #   atomix # puzzle game
  #   cheese # webcam tool
  #   epiphany # web browser
  #   evince # document viewer
  #   geary # email reader
  #   gedit # text editor
  #   gnome-characters
  #   gnome-music
  #   gnome-photos
  #   gnome-terminal
  #   gnome-tour
  #   hitori # sudoku game
  #   iagno # go game
  #   tali # poker game
  #   totem # video player
  # ]);

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
	# "org/gnome/desktop/interface" = {
	#   color-scheme = "prefer-dark";
	# };
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
