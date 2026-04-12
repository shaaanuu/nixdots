{ pkgs, lib, inputs, ... }:

let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  home.packages = with pkgs; [
    autotiling
    mako
  ];

  # wallpaper
  home.file.".config/sway/spiderverse.png".source = ../assets/spiderverse.png;

  wayland.windowManager.sway = {
    enable = true;
    package = unstable.swayfx;
    wrapperFeatures.gtk = true;
    checkConfig = false;

    config = rec {
      modifier = "Mod4";
      terminal = "foot";

      fonts = {
        names = [ "JetbrainsMono Nerd Font" ];
        size = 8.0;
      };

      gaps = {
        inner = 2;
        outer = 2;
      };

      # touchpad
      input."type:touchpad" = {
        dwt = "enabled";
        tap = "enabled";
        middle_emulation = "enabled";
        natural_scroll = "enabled";
        scroll_factor = "0.4";
        pointer_accel = "0.25";
        drag_lock = "disabled";
      };

      # borders
      window.border = 1;
      window.titlebar = false;
      colors.focused = {
        border = "#6c7086";
        background = "#285577";
        text = "#ffffff";
        indicator = "#45475a";
        childBorder = "#45475a";
      };

      # hold the mod key and use the left key to move
      # use the right key to resize
      floating.modifier = "${modifier} normal";

      bars = [{ command = "waybar"; }];
      # bars = [{ command = "waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css"; }];

      # wallpaper
      output = {
        "*".background = "~/.config/sway/spiderverse.png fill";
      };

      startup = [
        { command = "autotiling"; }
        { command = "mako"; always = true; }
        { command = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway XDG_SESSION_TYPE=wayland"; }
      ];

      keybindings = let
        mod = "Mod4";
        term = "foot";
        app-menu = "rofi -show drun";
        power-menu = "hmmm..."; # TODO: implement power menu.
      in {
        # terminal
        "${mod}+Return" = "exec ${term}";

        # kill focused window
        "${mod}+q" = "kill";

        # rofi
        "${mod}+d" = "exec ${app-menu}";

        # change focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # alternatively, you can use the cursor keys:
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        # move focused window
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # alternatively, you can use the cursor keys:
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # split in horizontal orientation
        "${mod}+Shift+v" = "split h";

        # split in vertical orientation
        "${mod}+v" = "split v";

        # enter fullscreen mode for the focused container
        "${mod}+f" = "fullscreen toggle";

        # change container layout (stacked, tabbed, toggle split)
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";

        # toggle tiling / floating
        "${mod}+Shift+space" = "floating toggle";

        # change focus between tiling / floating windows
        "${mod}+space" = "focus mode_toggle";

        # switch to workspace
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";

        # move focused container to workspace
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";

        # reload the configuration file
        "${mod}+Shift+r" = "reload";

        # exit sway
        "${mod}+Shift+q" = "exec swaymsg exit";

        # screenshot
        "Print" = "exec swaycut -m output";
        "${mod}+Print" = "exec swaycut -m window";
        "${mod}+Shift+Print" = "exec swaycut -m region";

        # volume key mapping
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +1%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -1%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";

        # resize window (you can also use the mouse for that)
        "${mod}+r" = "mode resize";
      };

      modes = {
        resize = {
          # These bindings trigger as soon as you enter the resize mode

          # Pressing left will shrink the window’s width.
          # Pressing right will grow the window’s width.
          # Pressing up will shrink the window’s height.
          # Pressing down will grow the window’s height.
          "h" = "resize shrink width 1 px or 1 ppt";
          "j" = "resize grow height 1 px or 1 ppt";
          "k" = "resize shrink height 1 px or 1 ppt";
          "l" = "resize grow width 1 px or 1 ppt";

          # same bindings, but for the arrow keys
          "Left" = "resize shrink width 1 px or 1 ppt";
          "Down" = "resize grow height 1 px or 1 ppt";
          "Up" = "resize shrink height 1 px or 1 ppt";
          "Right" = "resize grow width 1 px or 1 ppt";

          # back to normal: Enter or Escape or $mod+r
          "Return" = "mode default";
          "Escape" = "mode default";
          "${modifier}+r" = "mode default";
        };
      };
    };

    extraConfig = ''
      # fix going to workspace 10 by default
      workspace 1

      # fix for the larger cursor
      seat seat0 xcursor_theme Bibata-Modern-Classic 20

      # blur
      blur enable
      blur_radius 1

      # rounded corners
      corner_radius 10

      # title
      titlebar_padding 1 1
    '';
  };
}
