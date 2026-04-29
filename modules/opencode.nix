{ inputs, pkgs, lib, ... }:
{
  environment.systemPackages = [
    inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # ollama for, ofcourse...
  services.ollama = {
    enable = true;
    loadModels = [ "qwen3-coder:480b-cloud" ];
    package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.ollama;
  };

  # Turn on only manually
  systemd.services.ollama.wantedBy = lib.mkForce [ ];

  # switch for wake / kill
  programs.zsh.shellAliases = {
    ai = "sudo systemctl start ollama";
    ai-off = "sudo systemctl stop ollama";
  };
}
