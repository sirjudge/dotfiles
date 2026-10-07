{ pkgs, lib, ... }:
{
# Virtual box
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  virtualisation = {
    containers = {
      enable = true;
    };

    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      #dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };

    docker = {
      enable = true;
      liveRestore = true;
    };

    virtualbox = {
      host.enable = true;
      guest.enable = true;
      guest.dragAndDrop = true;
    };

  };


    # Useful other development tools
    environment.systemPackages = with pkgs; [
      dive # look into docker image layers
        podman-tui # status of containers in the terminal
        docker-compose # start group of containers for dev
        #podman-compose # start group of containers for dev
    ];
}
