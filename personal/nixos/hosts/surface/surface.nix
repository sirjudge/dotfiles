{ pkgs, lib, system, ... }:{

  #@surface-pro-intel.surface-control.enable = true;
  # Disable the problematic suspend kernel module, it makes waking up
  # impossible after closing the cover.
  # boot.blacklistedKernelModules = [ "surface_gpe" ];

  # Add the kernel modules such that we have a working keyboard for the 
  # LUKS full disk encryption.
  # https://github.com/linux-surface/linux-surface/wiki/Disk-Encryption
  #boot.initrd.kernelModules = [
  #  "surface_aggregator"
  #  "surface_aggregator_registry"
  #  "surface_aggregator_hub"
  #  "surface_hid_core"
  #  "surface_hid"
  #  "pinctrl_tigerlake"
  #  "intel_lpss"
  #  "intel_lpss_pci"
  #  "8250_dw"
  #];

  # surface stuff
  # microsoft-surface.surface-control.enable = true;  
  # microsoft-surface.ipts.enable = true;
  # microsoft-surface.kernelVersion = "surface-devel";
  # services.xserver.multitouch.enable = true; # is this the touch screen?
  # services.xserver.multitouch.invertScroll = true;
  # services.xserver.multitouch.ignorePalm = true;

  #services.xserver.libinput.enable = true;
  #services.xserver.libinput.naturalScrolling = false;
  #services.xserver.libinput.tapping = true;
  #services.xserver.libinput.disableWhileTyping = true;
  #services.xserver.libinput.horizontalScrolling = false;
  #services.xserver.modules = [ pkgs.xf86_input_wacom ];
  #services.xserver.wacom.enable = true;

}
