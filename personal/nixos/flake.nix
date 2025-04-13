# Load normal configuration
{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    hyprland.url = "github:hyprwm/Hyprland";
    ssbm-nix = {
      url = "github:NormalFall/ssbm-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
     rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };
    stylix.url = "github:danth/stylix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
 
  outputs = { self, nixpkgs, nixos-hardware,...} @inputs: {
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [ 
      	# nixos-hardware/microsoft/surface/surface-pro-intel
      	# nixos-hardware/microsoft/surface/common
	nixos-hardware.nixosModules.microsoft-surface-pro-intel
        ./hosts/surface/configuration.nix 
        inputs.hyprland.nixosModules.default
	inputs.stylix.nixosModules.stylix
	inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nico = import ./home/surface/home.nix;
        }
      ];
    };
  };
}


