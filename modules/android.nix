{ pkgs, config, inputs, ... }:

let
  androidPkgs = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;

    config = {
      allowUnfree = true;
    };
  };

  androidUser = config.users.users.shaaanuu;
  androidHome = androidUser.home;
  androidSdk = "${androidHome}/Android/Sdk";

  androidStudio = pkgs.symlinkJoin {
    name = "android-studio-writable-sdk";

    paths = [
      androidPkgs.android-studio
    ];

    nativeBuildInputs = [
      pkgs.makeWrapper
    ];

    postBuild = ''
      wrapProgram "$out/bin/android-studio" \
        --set ANDROID_HOME "${androidSdk}" \
        --unset ANDROID_SDK_ROOT \
        --unset ANDROID_NDK_ROOT
    '';
  };

in
{
  environment.systemPackages = [
    androidStudio
  ];

  systemd.tmpfiles.rules = [
    "d ${androidHome}/Android 0755 shaaanuu ${androidUser.group} - -"
    "d ${androidSdk} 0755 shaaanuu ${androidUser.group} - -"
  ];
}
