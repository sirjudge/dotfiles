#{pkgs, config, host, username, options, lib, inputs, system, ...}:
{pkgs, config, host, lib, system, ...}:
{
  services.xserver.digimend.enable = true;

  environment.systemPackages = [
    config.boot.kernelPackages.digimend
  ];
}
