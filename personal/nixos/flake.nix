# Load normal configuration
{
  description = "Configuration flake Nico's Development Environment";
  inputs = {
    godot.url = "github:Quoteme/nixos-godot-bin";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
    musnix = { url = "github:musnix/musnix"; };
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    # nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { self, godot, nixpkgs, hyprland-plugins, hyprland, zen-browser,... }
  @ inputs: 
  let 
    # initialize new settings
    username = "nico";
    hostname = "razer";
  in
  {
    # nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    nixosConfigurations.nico = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/razer/configuration.nix
        inputs.hyprland.nixosModules.default
        inputs.stylix.nixosModules.stylix
        inputs.musnix.nixosModules.musnix
        #BUG: Something is going wrong with the following godot imports
        # Keep em out for now until we need them
        # inputs.godot.packages.x86_64-linux.godot # for godot without Mono / C#
        # inputs.godot.packages.x86_64-linux.godotHeadless # for godot headless
        # inputs.godot.packages.x86_64-linux.godotMono
        inputs.home-manager.nixosModules.home-manager
        {
          nix.settings = {
            substituters = ["https://hyprland.cachix.org"];
            trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
          };
          home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux"; };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nico = import ./home/razer/home.nix;
        }
      ];
    };
  };
}
