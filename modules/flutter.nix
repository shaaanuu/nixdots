{ pkgs, ... }:

let
  androidenv = pkgs.callPackage "${pkgs.path}/pkgs/development/mobile/androidenv" {
    licenseAccepted = true;
  };

  android = androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "latest";

    platformVersions = [ "35" "36" ];

    buildToolsVersions = [ "35.0.0" ];

    includeNDK = true;

    ndkVersions = [ "28.2.13676358" ];

    cmakeVersions = [ "3.22.1" ];

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
