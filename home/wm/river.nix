{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.river = {
    enable = true;
    settings = {
      map = {
        normal = {
          "Super T" = "spawn wezterm";
          "Super R" = "spawn fuzzel";
          "Super W" = "close";
          "Super F" = "zoom";
          #          "None Print" = ''spawn grim -g "$(slurp)" | wl-copy'';
          "Super+Shift M" = "exit";
        };
      };

      map-pointer = {
        normal = {
          "Super BTN_LEFT" = "move-view";
          "Super BTN_RIGHT" = "resize-view";
          "Super BTN_MIDDLE" = "toggle-float";
        };
      };

      spawn = [
        "zen"
        "eww open bar"
        /*
        "${pkgs.wbg}/bin ../wallpaper.png"
        */
      ];

      focus-follows-cursor = "normal";

      default-layout = "rivertile";
    };

    extraSessionVariables = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      GDK_BACKEND = "wayland";
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    extraConfig = ''
      rivertile -view-padding 4 -outer-padding 4 &

        for i in $(seq 1 9)
        do
            tags=$((1 << ($i - 1)))

            riverctl map normal Super $i toggle-focused-tags $tags

            riverctl map normal Super+Shift $i set-view-tags $tags
        done
    '';
  };
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "river";
  };
}
