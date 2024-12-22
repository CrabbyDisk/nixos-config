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
  services.hyprpaper.enable = true;
}
