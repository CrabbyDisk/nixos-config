# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./wm
    ./cli
  ];

  # TODO: Set your username
  home = {
    username = "crabbydisk";
    homeDirectory = "/home/crabbydisk";
  };
  xdg.userDirs.enable = true;

  programs = {
    home-manager.enable = true;
    git.enable = true;
    kitty = {
      enable = true;
      themeFile = "Catppuccin-Mocha";
      settings = {
        confirm_os_window_close = 0;
        shell = "${pkgs.nushell}/bin/nu";
        font_family = "JetBrainsMono Nerd Font Mono";
      };
    };
    gh.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  gtk = {
    enable = true;
    theme.package = pkgs.catppuccin-gtk;
    theme.name = "Catppuccin Mocha";
  };

  home.packages = with pkgs; [
    vesktop
    qpwgraph
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
