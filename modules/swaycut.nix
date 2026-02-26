{ config, pkgs, lib, ... }:

let
  swaycut = pkgs.stdenv.mkDerivation {
    pname = "swaycut";
    version = "git";

    src = pkgs.fetchFromGitHub {
      owner = "shaaanuu";
      repo = "swaycut";
      rev = "main";
      sha256 = "1x1scbg5r5ig839als6swq73s4xi4db80cala54a97v6h4bi6gg3";
    };

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/bin
      cp swaycut $out/bin/swaycut
      chmod +x $out/bin/swaycut
    '';

    postPatch = ''
      substituteInPlace swaycut \
        --replace slurp ${pkgs.slurp}/bin/slurp \
        --replace grim ${pkgs.grim}/bin/grim \
        --replace jq ${pkgs.jq}/bin/jq \
        --replace wl-copy ${pkgs.wl-clipboard}/bin/wl-copy \
        --replace magick ${pkgs.imagemagick}/bin/magick \
        --replace notify-send ${pkgs.libnotify}/bin/notify-send
    '';
  };
in {
  environment.systemPackages = [ swaycut ];
}


