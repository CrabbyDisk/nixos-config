{
  pkgs,
  config,
  lib,
  input,
  ...
}: {
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        idle-timeout = 1000;
        lsp = {
          display-inlay-hints = true;
          display-progress-messages = true;
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        bufferline = "always";
        line-number = "relative";
      };
    };
    languages = {
      language = [
        {
          name = "rust";
          auto-format = true;
        }
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.alejandra;
        }
      ];

      language-server = {
        rust-analyzer = {
          config = {
            check.command = "clippy";
            cargo.features = "all";
          };
        };
        nixd = {
          command = lib.getExe pkgs.nixd;
          options = {
            nixos = {
              expr = "(builtins.getFlake \"/home/crabbydisk/nixos\").nixosConfigurations.good-pc.options";
            };
            home-manager = {
              expr = "(builtins.getFlake \"/home/crabbydisk/nixos\").homeConfigurations.crabbydisk.options";
            };
          };
        };
      };
    };
  };
}
