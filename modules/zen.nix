{ inputs, pkgs, config, ... }: 

{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    policies = {
      AutofillAddressEnabled = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      DisableTelemetry = true;
      DisableFeedbackCommands = true;
      DisablePocket = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          allowed_private_browsing = true;
        };
        "nook.startpage@shaaanuu.dev" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/startpage-nook/latest.xpi";
          allowed_private_browsing = true;
        };
      };
    };

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      settings = {
        "zen.urlbar.replace-newtab" = false;
      };

      mods = [
        "a6335949-4465-4b71-926c-4a52d34bc9c0" # Better Find Bar
        "c8d9e6e6-e702-4e15-8972-3596e57cf398" # Zen Back Forward
        "cb15abdb-0514-4e09-8ce5-722cf1f4a20f" # Hide Extension Name
        "fd24f832-a2e6-4ce9-8b19-7aa888eb7f8e" # Quietify
      ];

      search = {
        default = "ddg";
        privateDefault = "ddg";
        force = true;
        engines = {
          "ddg" = {
            urls = [{ template = "https://duckduckgo.com/?q={searchTerms}"; }];
            definedAliases = [ "@ddg" "@duck" ];
          };
          "nix" = {
            urls = [{ template = "https://search.nixos.org/packages?query={searchTerms}"; }];
            definedAliases = [ "@nix" ];
          };
          "wikipedia" = {
            urls = [{ template = "https://en.wikipedia.org/w/index.php?search={searchTerms}"; }];
            definedAliases = [ "@w" "@wiki" ];
          };
        };
      };

      extraConfig = ''
        // betterfox config (https://github.com/yokoffing/Betterfox)
        ${builtins.readFile "${inputs.betterfox}/Fastfox.js"}
        ${builtins.readFile "${inputs.betterfox}/Securefox.js"}
        ${builtins.readFile "${inputs.betterfox}/Peskyfox.js"}
        ${builtins.readFile "${inputs.betterfox}/zen/user.js"}

        // location
        user_pref("permissions.default.geo", 0);

        // DNS-over-HTTPS (DoH)
        user_pref("network.trr.uri", "https://dns.quad9.net/dns-query");
        user_pref("network.trr.mode", 3);

        // ask where to save every file or to open
        user_pref("browser.download.useDownloadDir", false);
        user_pref("browser.download.always_ask_before_handling_new_types", false);

        // default newtab
        user_pref("browser.newtabpage.enabled", false);
        user_pref("browser.urlbar.suggest.topsites", false);

        // disable login manager
        user_pref("signon.rememberSignons", false);
      '';
    };
  };

  # for whatever dumb reasons, zen wants the configs in ~/.zen/ and nix gives it in ~/.config/zen/
  home.file.".zen".source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/zen";
}
