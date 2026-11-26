{ inputs, ... }:

{
  imports = [
    inputs.artcraft.nixosModules.default
  ];

  programs.artcraft = {
    enable = true;
    apps = [ "figcraft" ];
    linkFonts = true;
  };
}
