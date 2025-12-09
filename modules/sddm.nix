{ pkgs, inputs, ... }:

let
  bg = pkgs.runCommand "bg" { } "install -Dm644 ${../wall.jpg} $out";

  sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
    theme = "default";
    extraBackgrounds = [bg];
    theme-overrides = {
      "LoginScreen" = {
        background = "bg";
        blur = 30;
      };
      "LockScreen" = {
        background = "bg";
        blur = 0;
      };
      "LockScreen.Clock" = {
        format = "hh:mm AP";
        font-size = 50;
      };
      "LockScreen.Date" = {
        font-size = 10;
        margin-top = 5;
      };
      "LockScreen.Message" = {
        font-size = 10;
        icon-size = 14;
      };
    };
  };
in 

{
  environment.systemPackages = [sddm-theme sddm-theme.test];
   qt.enable = true;
   services.displayManager.sddm = {
      package = pkgs.lib.mkDefault pkgs.kdePackages.sddm; 
      enable = true;
      theme = sddm-theme.pname;
      extraPackages = sddm-theme.propagatedBuildInputs;
      settings = {
        General = {
          GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
          InputMethod = "qtvirtualkeyboard";
        };
      };
   };
}
