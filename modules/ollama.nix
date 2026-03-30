{ config, pkgs, lib, inputs, ... }:

{
  services.ollama = {
    enable = true;
    loadModels = [ "qwen3:0.6b" "qwen3.5:0.8b" "qwen3.5:397b-cloud" "qwen3-coder:480b-cloud" ];
    package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.ollama;
  };
  services.open-webui.enable = true;

  # Turn on only manually
  systemd.services.ollama.wantedBy = lib.mkForce [ ];
  systemd.services.open-webui.wantedBy = lib.mkForce [ ];

  # switch for wake / kill
  programs.zsh.shellAliases = {
    ai = "sudo systemctl start ollama open-webui";
    ai-off = "sudo systemctl stop ollama open-webui";
  };
}
