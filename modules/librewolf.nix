{ ... }: 

{
  programs.librewolf = {
    enable = true;

    policies = {
      ExtensionSettings = {
        "nook.startpage@shaaanuu.dev" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/startpage-nook/latest.xpi";
          private_browsing = true;
        };
      };
    };

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      search = {
        default = "ddg";
        privateDefault = "ddg";
        force = true;
        engines = {
          "ddg" = {
            name = "DuckDuckGo";
            urls = [{ template = "https://duckduckgo.com/?q={searchTerms}"; }];
            definedAliases = [ "@ddg" "@duck" ];
          };
          "nix" = {
            name = "NixOS Packages";
            urls = [{ template = "https://search.nixos.org/packages?query={searchTerms}"; }];
            definedAliases = [ "@nix" ];
          };
          "wikipedia" = {
            name = "Wikipedia";
            urls = [{ template = "https://en.wikipedia.org/w/index.php?search={searchTerms}"; }];
            definedAliases = [ "@w" "@wiki" ];
          };
        };
      };

      settings = {
        # hide the bookmarks toolbar
        "browser.toolbars.bookmarks.visibility" = "never";

        # don't close window with last tab
        "browser.tabs.closeWindowWithLastTab" = false;

        # vertical tabs
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.main.tools" = "bookmarks";

        # zen browser's smooth scrolling (might not work properly)
        "apz.overscroll.enabled" = true;
        "general.smoothScroll" = true;
        "general.smoothScroll.msdPhysics.enabled" = true;
        "general.smoothScroll.currentVelocityWeighting" = "0.15";
        "general.smoothScroll.stopDecelerationWeighting" = "0.6";
        "mousewheel.min_line_scroll_amount" = 10;
        "general.smoothScroll.mouseWheel.durationMinMS" = 80;
        "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
        "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
        "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
        "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
        "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
        "mousewheel.default.delta_multiplier_y" = 200;

        # custom CSS (userChrome)
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      extraConfig = ''
        // DNS-over-HTTPS (DoH)
        user_pref("network.trr.uri", "https://dns.quad9.net/dns-query");
        user_pref("network.trr.mode", 3);

        // ask where to save every file or to open
        user_pref("browser.download.always_ask_before_handling_new_types", true);

        // default newtab
        user_pref("browser.newtabpage.enabled", false);
        user_pref("browser.urlbar.suggest.topsites", false);
      '';

      userChrome = ''
        /* Hide sidebar customization button */
        moz-button[view="viewCustomizeSidebar"] {
          display: none !important;
        }

        /* Hide sidebar overflow tools button */
        button-group.tools-and-extensions.actions-list.overflow-button {
          display: none !important;
        }

        /* Dim the sidebar bookmarks button */
        #main-button {
          opacity: 0.7 !important;
        }

        /* Hide extension identity indicator */
        #identity-box.extensionPage {
          display: none !important;
        }

        /* Hide "List All Tabs" - toolbar */
        #alltabs-button {
          display: none !important;
        }

        /* Hide "New Tab" - toolbar */
        #new-tab-button {
          display: none !important;
        }

        /* Dim the sidebar toolbar button */
        #sidebar-button {
          opacity: 0.7 !important;
        }
      '';
    };
  };

  # default browser
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "librewolf.desktop" ];
      "application/xhtml+xml" = [ "librewolf.desktop" ];
      "x-scheme-handler/http" = [ "librewolf.desktop" ];
      "x-scheme-handler/https" = [ "librewolf.desktop" ];
    };
  };
}

