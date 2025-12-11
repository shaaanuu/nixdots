{ config, lib, pkgs, inputs, ... }:

let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in

{
  imports = [ ./hardware-configuration.nix ];

  nixpkgs.config.allowUnfree = true;

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
    vim
    wget
    alacritty
    git
    libimobiledevice
    ifuse
    catppuccin-gtk
    capitaine-cursors
  ] ++ [
    unstable.swayfx
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}
