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
          "Super+Shift M" = "exit";
        };
      };

      map-pointer = {
        normal = {
          "Super BTN_LEFT" = "move-view";
          "Super BTN_RIGHT" = "resize-view";
        };
      };

      focus-follows-cursor = "normal";

      keyboard-layout = "-options caps:swapescape us";

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
      rivertile -view-padding 6 -outer-padding 6 &
    '';
  };
}
