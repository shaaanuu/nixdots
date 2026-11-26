{ inputs, pkgs, ... }:

let
  artcraft = inputs.artcraft.packages.${pkgs.stdenv.hostPlatform.system};

  apps = [
    "figcraft"
  ];

  mkApp = name:
    artcraft.${name}.overrideAttrs (old: {
      runtimeDependencies =
        (old.runtimeDependencies or []) ++ [ pkgs.dbus.lib ];
    });

in
{
  environment.systemPackages =
    (map mkApp apps) ++ [
      pkgs.zenity
    ];

  # ArtCraft font integration
  fonts.fontDir.enable = true;

  systemd.tmpfiles.rules = [
    "d /usr/share 0755 root root -"
    "L+ /usr/share/fonts - - - - /run/current-system/sw/share/X11/fonts"
  ];
}
