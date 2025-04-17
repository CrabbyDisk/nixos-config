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

  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };

  # TODO: Set your username
  home = {
    username = "crabbydisk";
    homeDirectory = "/home/crabbydisk";
  };

  programs = {
    nix-index.enable = true;
    bash.enable = true;

    home-manager.enable = true;

    foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          shell = "${pkgs.nushell}/bin/nu";
        };
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      kdePackages.fcitx5-qt
    ];
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = ./wallpaper.png;
    cursor = {
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 16;
      name = "catppuccin-mocha-dark-cursors";
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto Medium";
      };
    };
  };

  home.sessionVariables = {
    "_ZO_RESOLVE_SYMLINKS" = 1;
    "EDITOR" = "nvim";
  };

  xdg.userDirs.enable = true;
  home.packages = with pkgs; [
    (prismlauncher.override {
      jdks = [graalvm-ce];
      additionalLibs = [wayland libxkbcommon];
    })
    osu-lazer-bin
    zoom-us
    kdePackages.ark
    libqalculate

    slurp
    grim
    swappy

    fastfetch
    wl-clipboard
    openai-whisper
    # kdePackages.kdenlive

    libreoffice-fresh

    usbutils
    inkscape
    # blender
    piper
    gimp-with-plugins

    abaddon
    universal-android-debloater
    android-tools
    wineWowPackages.staging
    gparted

    (discord-canary.override {
      withVencord = true;
    })
    wakatime-cli
    qpwgraph
    nom
    obsidian
    catppuccin-cursors
    inputs.zen-browser.packages."${system}".default
    outputs.packages."x86_64-linux".nvf
    nvidia_oc
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
