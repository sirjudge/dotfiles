{ config, pkgs, ... }:

let
  myPackages = [
    pkgs.pkg-config
    pkgs.udev
    pkgs.alsa-lib
    pkgs.vulkan-loader
    pkgs.xorg.libX11
    pkgs.xorg.libXcursor
    pkgs.xorg.libXi
    pkgs.xorg.libXrandr
    pkgs.libxkbcommon
    pkgs.wayland
  ];
in
{
  home.packages = myPackages;

  home.sessionVariables = {
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath myPackages;
  };
}

