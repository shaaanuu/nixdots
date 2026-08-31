{ pkgs, ... }:

let
  androidenv = pkgs.callPackage "${pkgs.path}/pkgs/development/mobile/androidenv" {
    licenseAccepted = true;
  };

  android = androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "latest";

    platformVersions = [ "33" ];

    buildToolsVersions = [ "latest" ];

    includeNDK = true;

    ndkVersions = [ "latest" ];

    cmakeVersions = [ "latest" ];

    extraLicenses = [
      "android-sdk-preview-license"
      "android-googletv-license"
      "android-sdk-arm-dbt-license"
      "google-gdk-license"
      "intel-android-extra-license"
      "intel-android-sysimage-license"
      "mips-android-sysimage-license"
      "android-googlexr-license"
    ];
  };
in
{
  environment.systemPackages = [
    pkgs.flutter
    pkgs.jdk17
    android.androidsdk
  ];

  environment.variables = {
    ANDROID_HOME = "${android.androidsdk}/libexec/android-sdk";
  };
}
