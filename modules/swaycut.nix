{ config, pkgs, lib, ... }:

let
  swaycut = pkgs.stdenv.mkDerivation {
    pname = "swaycut";
    version = "git";

    src = pkgs.fetchFromGitHub {
      owner = "shaaanuu";
      repo = "swaycut";
      rev = "main";
      sha256 = lib.fakeSha256; # will replace, i guess...
    };

    dontBuild = true;

    installPhase = ''
      install -Dm755 swaycut $out/bin/swaycut
      install -Dm644 LICENSE $out/share/licenses/swaycut/LICENSE
    '';

    propagatedBuildInputs = [ pkgs.grim pkgs.slurp pkgs.jq pkgs.wl-clipboard pkgs.imagemagick pkgs.libnotify ];
  };
in {
  environment.systemPackages = [ swaycut ];
}

