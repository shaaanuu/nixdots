{ config, pkgs, system, inputs, ... }:

let
  dots = "/etc/nixos/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    alacritty = "alacritty";
    sway = "sway";
    waybar = "waybar";
    rofi = "rofi";
    fastfetch = "fastfetch";
    mako = "mako";
    nvim = "nvim";
    yazi = "yazi";
    labwc = "labwc";
  };
in

{
  home.username = "shaaanuu";
  home.homeDirectory = "/home/shaaanuu";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    rofi-wayland
    yazi
    alacritty
    fastfetch
    mako
    neovim
    xfce.thunar
    xfce.thunar-volman
    xfce.mousepad
    xfce.tumbler
    xfce.ristretto
    feh
    labwc
    nwg-look
    gcc
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
    libplist
    libnotify

    # unstable
    inputs.zen-browser.packages."${system}".default
    inputs.nixpkgs-unstable.legacyPackages."${system}".flutter
  ];

  # for in ~/.configs/
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dots}/${subpath}";
    recursive = true;
  }) configs;

  # exceptions
  home.file.".local/share/oh-my-zsh/custom/themes/spiderverse.zsh-theme".source = create_symlink "${dots}/zsh/spiderverse.zsh-theme";

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "spiderverse";
    };
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      clean = "sudo nix-collect-garbage -d";
      shutdown = "sudo shutdown now";
      restart = "sudo reboot now";
      reboot = "sudo reboot now";
      snvim = "sudo -E nvim";
    };
    sessionVariables.ZSH_CUSTOM = ".local/share/oh-my-zsh/custom";
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };
}
