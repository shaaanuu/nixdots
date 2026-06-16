{ pkgs, ... }:

let
  cmdlineToolsVer = "19.0";

  android = pkgs.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = cmdlineToolsVer;
    platformVersions = [ "27"  "36" ];
    buildToolsVersions = [ "27.0.3" "35.0.0" ];
    includeNDK = true;
    ndkVersions = [ "28.2.13676358" ];
    cmakeVersions = [ "3.22.1" ];
  };

  android-sdk = pkgs.runCommand "android-sdk-with-latest" { } ''
    mkdir -p $out
    ln -s -t $out ${android.androidsdk}/libexec/android-sdk/*
    rm $out/cmdline-tools
    mkdir $out/cmdline-tools
    ln -s -t $out/cmdline-tools ${android.androidsdk}/libexec/android-sdk/cmdline-tools/*
    ln -sfn ${cmdlineToolsVer} $out/cmdline-tools/latest
  '';
in
{
  environment.systemPackages = [
    pkgs.flutter
    pkgs.jdk17
    android.androidsdk
  ];

  nixpkgs.config.android_sdk.accept_license = true;

  environment.variables = {
    # ANDROID_SDK_ROOT = "${android.androidsdk}/libexec/android-sdk";
    # ANDROID_HOME = "${android.androidsdk}/libexec/android-sdk";
    ANDROID_SDK_ROOT = "${android-sdk}";
    ANDROID_HOME = "${android-sdk}";
  };

  environment.sessionVariables = {
    PATH = "$ANDROID_HOME/cmdline-tools/latest/bin:$PATH";
  };
}
