{ config, pkgs, lib, inputs, ... }:

let
  dots = "/etc/nixos/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    foot = "foot";
    waybar = "waybar";
    rofi = "rofi";
    fastfetch = "fastfetch";
    mako = "mako";
    nvim = "nvim";
    yazi = "yazi";
  };
in

{
  imports = [
    ./modules/zen.nix
    ./modules/swayfx.nix
    ./modules/zed.nix
  ];

  home.username = "shaaanuu";
  home.homeDirectory = "/home/shaaanuu";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    rofi
    yazi
    fastfetch
    mako
    neovim
    xfce.mousepad
    feh
    nwg-look
    gcc
    fontconfig
    noto-fonts-color-emoji
    noto-fonts
    vscodium
    localsend
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

    # theme
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct

    # unstable
    # inputs.nixpkgs-unstable.legacyPackages."${pkgs.stdenv.hostPlatform.system}".PKGNAME
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
      upgrade = "sudo nix flake update --flake /etc/nixos";
      clean = "sudo nix-collect-garbage -d";
      shutdown = "sudo shutdown now";
      restart = "sudo reboot now";
      reboot = "sudo reboot now";
      snvim = "sudo -E nvim";
    };
    sessionVariables = {
      ZSH_CUSTOM = "${config.home.homeDirectory}/.local/share/oh-my-zsh/custom";
    };
    initContent = ''
      export BUN_INSTALL="$HOME/.bun"
      export PATH="$BUN_INSTALL/bin:$PATH"
    '';
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };

  # GTK
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-blue-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "blue";
      };
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-recent-files-limit = 0;
      };
    };
    gtk4.extraConfig.gtk-recent-files-limit = 0;
  };

  # Cursor
  home.pointerCursor = {
    gtk.enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 20;
  };

  # xdg-user-dirs
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
