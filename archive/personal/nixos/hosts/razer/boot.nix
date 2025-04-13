{ config, ... }:
{
  boot.extraModulePackages = [ 
    config.boot.kernelPackages.gcadapter-oc-kmod
  ];

  # Bootloader.
  boot = {
    loader = {
        systemd-boot.enable = true;
	efi.canTouchEfiVariables = true;
    };

    #TODO: gonna uncomment this out, wonder if it'll fix anything magically. . . would be nice
    # causes weird issues with not recognizing the dock on start up
    # blacklistedKernelModules = [
    # 	"dell_smbios"	
    # ];
    
    kernelParams = [ 
      "psmouse.synaptics_intertouch=0"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];

    kernelModules = ["evdi" "udl"  "gcadapter_oc" ];
  };
}
