{ pkgs, lib, config, ... }:
{
  environment.sessionVariables = rec {
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_10_0-bin}/share/dotnet";
    DOTNET_ENVIRONMENT = "Development";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.136"
  ];

  environment.systemPackages = with pkgs; [
    godot_4
    omnisharp-roslyn
    godot_4-mono
    godot-mono
    (with dotnetCorePackages; combinePackages [
      dotnet_8.sdk
      dotnet_9.sdk
      dotnet_10.sdk
    ])
  ];
}

