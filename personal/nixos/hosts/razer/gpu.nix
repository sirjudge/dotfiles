{ config, lib, pkgs, ... }:

{
  ######################
  # BELOW IS NEW STUFF #
  ######################
  # Load video driver
  services.xserver.videoDrivers = [ "nvidia" ];

  #programs.gamemode.enable = true;

  # Enable nvidia executables via containers
  hardware.nvidia-container-toolkit.mount-nvidia-executables = true;

  # enable docker to also use nvidia card
  #virtualisation.docker.enableNvidia = true;

  ######################
  # ABOVE IS NEW STUFF #
  ######################

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      #vpl-gpu-rt          # for newer GPUs on NixOS >24.05 or unstable
      # onevpl-intel-gpu  # for newer GPUs on NixOS <= 24.05
      intel-media-sdk   # for older GPUs
    ];
  };

  # Might need to do some more stuff maybe
  #https://nixos.wiki/wiki/Intel_Graphics

  # Load nvidia driver for Xorg and Wayland
  # Shout out tmatklad for telling me to add the intel drivers.
  # https://discourse.nixos.org/t/laptop-screen-not-detected/20117/3
  #services.xserver.videoDrivers = ["intel" "nvidia"];
  hardware.nvidia = {
  # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;
  
  # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    #package = config.boot.kernelPackages.nvidiaPackages.stable;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    #package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  hardware.nvidia.prime = {
    offload = {
       # Enable offloading to the GPU
       enable = true;

	# If previous setting is enabled, also enable the offload command
    	enableOffloadCmd = true;
    };

    # Cannot have both sync AND offload. Sync keeps the GPU loaded and ready at the cost of power and performance
    #sync.enable = true;

    # Bus Ids for intel and nvidia chips
    # run the following to view
    # sudo lshw -C display                                                                                          [9:16:32]
    intelBusId = "PCI:0:2:0";      # Adjusted for your Intel GPU (i915)
    nvidiaBusId = "PCI:1:0:0";     # Adjusted for your Nvidia GPU};
  };

  # Dock and GPU kernel imports to make I think.
  # TODO: I need to revist this at some point to see if I still need it or if it should move elsewhere
  boot.kernelParams = ["nvidia-drm.modeset=1"];
}
