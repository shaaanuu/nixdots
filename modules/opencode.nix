{ inputs, pkgs, lib, ... }:
{
  environment.systemPackages = [
    inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
