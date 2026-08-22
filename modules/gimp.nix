{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    inputs.nix-photogimp3.packages.${pkgs.system}.default
  ];
}
