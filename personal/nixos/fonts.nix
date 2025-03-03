{ config, pkgs, lib,... }:
{
    fonts.packages = with pkgs; [ nerdfonts ];
}
