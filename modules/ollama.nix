{ config, pkgs, lib, inputs, ... }:

{
  services.ollama = {
    enable = true;
    loadModels = [ "qwen3:0.6b" "qwen3.5:0.8b" ];
    package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.ollama;
  };
  services.open-webui.enable = true;
}
