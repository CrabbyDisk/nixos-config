{
  pkgs,
  config,
  lib,
  input,
  ...
}: {
  imports = [
    ./hyprland.nix
  ];
  programs.eww = {
    enable = true;
    configDir = ./eww;
  };
  programs.wofi.enable = true;

  services.mako = {
    enable = true;
  };
  services.hyprpaper.enable = true;
}
