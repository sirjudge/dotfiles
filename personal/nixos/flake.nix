# Load normal configuration
{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
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
    musnix  = { url = "github:musnix/musnix"; };
  };
 
  outputs = { self, nixpkgs, hyprland-plugins, hyprland, ...} @inputs: {
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
	

    # import modules into current configuration
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [ 
        ./hosts/razer/configuration.nix 
        inputs.hyprland.nixosModules.default
	inputs.stylix.nixosModules.stylix
        inputs.musnix.nixosModules.musnix
	inputs.home-manager.nixosModules.home-manager
        {
	  home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nico = import ./home/razer/home.nix;
        }
      ];
    };
  };
}


