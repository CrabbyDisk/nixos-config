{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    config = {
      cudaSupport = true;
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    channel.enable = false;
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes ca-derivations";
      # Opinionated: disable global registry
      auto-optimise-store = true;
      max-jobs = 4;

      trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://cuda-maintainers.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      ];
    };
    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  boot = {
    plymouth.enable = true;
    loader.systemd-boot.enable = true;
    kernelPackages = pkgs.linuxPackages_zen;
  };

  hardware.nvidia = {
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  hardware.graphics.enable = true;

  time.timeZone = "America/Toronto";
  services = {
    # Nvidia
    xserver.videoDrivers = ["nvidia"];

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    displayManager = {
      autoLogin = {
        enable = true;
        user = "crabbydisk";
      };
      sddm.enable = true;
    };
    xserver.enable = true;

    keyd = {
      enable = true;
      keyboards.default = {
        settings = {
          global = {
            default_layout = "colemak";
          };
          main = {
            capslock = "overload(control, esc)";
          };
        };
        extraConfig = "include layouts/colemak";
      };
    };

    udisks2.enable = true;
    ratbagd.enable = true;

    printing = {
      enable = true;
      drivers = [pkgs.hplip];
    };

    pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk];
  };

  networking = {
    hostName = "good-pc";
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    networkmanager.enable = true;
    networkmanager.dns = "none";
  };

  security.rtkit.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-extra
  ];
  programs = {
    hyprland = {
      enable = true;
    };

    river.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    localsend.enable = true;

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep 15";
    };
  };

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    crabbydisk = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      isNormalUser = true;
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel" "networkmanager" "audio" "plugdev"];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
