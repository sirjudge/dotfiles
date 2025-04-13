{ pkgs, lib, ... } :
{
  programs.neovim = {
    enable = true;
    # defaultEditor = true;
    extraConfig = lib.fileContents /home/nico/.config/home-manager/nvim/config/init.lua;
  };

}
