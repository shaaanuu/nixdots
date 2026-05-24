{ inputs, pkgs, lib, unstable, ... }:

{
  programs.zed-editor = {
    enable = true;
    package = unstable.zed-editor;
    extensions = [ "nix" "catppuccin-blur" "html" ];
    userSettings = {
      auto_update = false;
      buffer_font_family = "JetBrainsMono Nerd Font";
      theme = {
        mode = "dark";
        light = "Catppuccin Frappé (Blur)";
        dark = "Catppuccin Mocha (Blur)";
      };
      vim_mode = true;
      disable_ai = true;
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      minimap.show = "always";
      format_on_save = "off";
      buffer_font_size = 13;
      ui_font_size = 14;
      restore_on_startup = "launchpad";
      collaboration_panel.button = false;
      outline_panel.button = false;
      debugger.button = false;
      git_panel.button = false;
      terminal.button = false;
      diagnostics.button = false;
      global_lsp_settings.button = false;
      title_bar = {
        show_project_items = false;
        show_branch_name = false;
        show_branch_status_icon = false;
        show_sign_in = false;
        show_user_menu = false;
      };
      toolbar = {
        quick_actions = false;
        selections_menu = false;
      };
      tab_bar.show_tab_bar_buttons = false;
      status_bar.active_language_button = false;
    };
  };
}
