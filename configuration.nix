{ config, lib, pkgs, inputs, ... }:

let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in

{
  imports = [
    ./hardware-configuration.nix
    # ./modules/swaycut.nix
  ];

  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;
  home-manager.backupFileExtension = "backup";

  # sway stuffs...
  hardware.bluetooth.enable = true;
  programs.sway.enable = true;
  security.polkit.enable = true;
  hardware.graphics.enable = true;
  services = {
    dbus.enable = true;
    udev.enable = true;
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  # electron issues
  programs.dconf.enable = true;
  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata Cursors";
    XCURSOR_SIZE = "24";
    NIXOS_OZONE_WL = "1";
  };

  # sddm
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  systemd.tmpfiles.rules = let
    user = "shaaanuu";
    iconPath = ./avatar;
  in [
    "f+ /var/lib/AccountsService/users/${user}  0600 root root -  [User]\\nIcon=/var/lib/AccountsService/icons/${user}\\n"
    "L+ /var/lib/AccountsService/icons/${user}  -    -    -    -  ${iconPath}"
  ];
  
  # zsh
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;

  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.timeoutStyle = "hidden";
  boot.loader.timeout = 0;
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;
  boot.kernelParams = [ "quiet" "udev.log_priority=3" ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Time zone.
  time.timeZone = "Asia/Kolkata";

  # ios stuffs
  services.usbmuxd.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # User
  users.users.shaaanuu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      tree
    ];
  };

  # packages in system profile.
  environment.systemPackages = with pkgs; [
    xdg-user-dirs
    vim
    wget
    alacritty
    git
    libimobiledevice
    ifuse
    mesa
    libglvnd

    # python
    (python3.withPackages (python-pkgs: with python-pkgs; [
      yt-dlp
      ffmpeg
    ]))
  ] ++ [
    unstable.swayfx
  ];

  # Thunar
  programs.thunar.enable = true;
  services.tumbler.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}
