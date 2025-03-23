{ pkgs, lib, ... }:
{
  virtualisation.docker.enable = true;
  virtualisation.docker.liveRestore = false;

   # Virtual box
   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
   virtualisation.virtualbox.guest.enable = true;
   virtualisation.virtualbox.guest.dragAndDrop = true;
}


