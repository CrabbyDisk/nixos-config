{
  pkgs,
  config,
  lib,
  input,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./river.nix
  ];
  programs.eww = {
    enable = true;
    configDir = ./eww;
  };
  programs.fuzzel.enable = true;

  services.mako = {
    enable = true;
  };
  services.hyprpaper.enable = true;
}
