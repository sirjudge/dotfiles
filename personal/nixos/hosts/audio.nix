{ pkgs, lib, config, ... }:
{

  # TODO: THis doesn't work with flakes
  # imports =
  # [ # ...
  #   <musnix>
  # ];
  # musnix.enable = true;
  
  users.users.nico.extraGroups = [ "audio" ];

  #hardware.pulseaudio.enable = false;
  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    #pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.mpd = {
    enable = true;
    musicDirectory = "/home/nico/Music";
    extraConfig = ''
    # must specify one or more outputs in order to play audio!
    # (e.g. ALSA, PulseAudio, PipeWire), see next sections
    audio_output {
      type "pipewire"
      name "My PipeWire Output"
    }
    ''; 

    # Optional:
    network.listenAddress = "any"; # if you want to allow non-localhost connections
    #network.startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  };
}
