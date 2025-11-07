{ pkgs, lib, ... }:
{
  virtualisation.docker.enable = true;
  virtualisation.docker.liveRestore = false;
}
