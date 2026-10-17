{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    inputs.nix-photogimp3.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
