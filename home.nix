{ config, pkgs, system, inputs, ... }:

let
  dots = "${config.home.homeDirectory}/nixdots/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    alacritty = "alacritty";
    sway = "sway";
    waybar = "waybar";
    rofi-wayland = "rofi";
    fastfetch = "fastfetch";
    mako = "mako";
    neovim = "nvim";
    yazi = "yazi";
  };
in

{
  home.username = "shaaanuu";
  home.homeDirectory = "/home/shaaanuu";
  home.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    swayfx
    waybar
    rofi-wayland
    yazi
    alacritty
    fastfetch
    mako
    neovim
    xfce.thunar
    xfce.thunar-volman
    xfce.mousepad
    zsh
    oh-my-zsh
    labwc
    nwg-look
    gcc
    nerd-fonts.jetbrains-mono
    pipewire
    wireplumber
    pavucontrol
    fontconfig
    noto-fonts-emoji
    noto-fonts
    vscodium
    localsend
    zed-editor
    obsidian
    vlc
    xarchiver
    jdk17
    xfce.tumbler
    gvfs
    file-roller
    unzip
    zip
    unrar
    p7zip
    exiftool
    brightnessctl
    bluez
    bluez-tools
    networkmanager
    libimobiledevice
    ifuse
    usbmuxd
    libplist

    # unstable
    inputs.zen-browser.packages."${system}".default
    inputs.nixpkgs-unstable.legacyPackages."${system}".flutter
  ];
 
  # for in ~/.configs/
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink  "${dots}/${subpath}";
    recursive = true;
  }) configs;

  # exceptions
  home.file.".zshrc".source = create_symlink "${dots}/zsh/.zshrc";
  home.file.".oh-my-zsh".source = create_symlink "${dots}/zsh/.oh-my-zsh";

  programs.home-manager.enable = true;
}
