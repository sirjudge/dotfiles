{ config, pkgs, lib,inputs,system,... }:

let 
  system = "x86_64-linux";
  bevyLibPath = pkgs.lib.makeLibraryPath [ 
    pkgs.vulkan-loader 
    pkgs.libxkbcommon 
    pkgs.wayland
    pkgs.alsa-lib 
    pkgs.udev 
  ];
  bindgenClangArgs = "-I${pkgs.glibc.dev}/
    include -I${pkgs.llvmPackages_latest.libclang.lib}/lib/clang/
    ${pkgs.llvmPackages_latest.libclang.version}/include -I${pkgs.glib.dev}/include/glib-2.0
    -I${pkgs.glib.out}/lib/glib-2.0/include/";
in
{
  # programs.home-manager.enable = true;
# Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    sessionPath = [ "$HOME/.cargo/bin" ];
    username = "nico";
    homeDirectory = "/home/nico";
    sessionVariables = {
      OPENSSL_DIR = "${pkgs.openssl.dev}";
      OPENSSL_DEV = "${pkgs.openssl.dev}";
      OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
      OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
      OPENSSL_NO_VENDOR = "1";
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.openssl.out}/lib/pkgconfig:
        $PKG_CONFIG_PATH";

      CARGO_HOME = "$HOME/.cargo";
      RUSTUP_HOME = "$HOME/.rustup";
      LIBCLANG_PATH = "${pkgs.llvmPackages_latest.libclang.lib}/lib";
      BINDGEN_EXTRA_CLANG_ARGS = bindgenClangArgs;
      RUSTFLAGS = "-C link-arg=-fuse-ld=lld";
      LD_LIBRARY_PATH = "${bevyLibPath}:$LD_LIBRARY_PATH";

      EDITOR = "nvim";
      XDG_CONFIG_HOME = "/home/nico/.config/";
      GTK_USE_PORTAL = "1";
      NIXOS_OZONE_WL = "1";
      QT_SCALE_FACTOR = "1";
      __GR_VRR_ALLOWED = "0";
      __GR_GSYNC_ALLOWED = "0";
      BROWSER = "firefox";
      MOZ_ENABLE_WAYLAND = 1;  
    };
    
    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    };

    stateVersion = "24.11"; # Please read the comment before changing.
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # load files after home manager has been loaded and initialized
  imports = [
    ./terminal/tmux.nix 
    ./terminal/kitty.nix
    ./terminal/shell.nix
    ./git.nix
    ./wofi.nix
    ./hyprland/hyprland.nix
    ./waybar/waybar.nix
  ];

  gtk = {
	  enable = true;
	  # font.name = "Ubuntu Nerd Font";
	  font.name = "JetBrainsMono Nerd Font";
	  theme = {
		  name = "rose-pine";
		  package = pkgs.rose-pine-gtk-theme;
	  };
	  iconTheme = {
		  name = "Rose pine icons";
		  package = pkgs.rose-pine-icon-theme;
	  };
  };

  qt.enable = true;
  qt.platformTheme.name = "qtct";
}
