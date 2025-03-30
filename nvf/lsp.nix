{pkgs, ...}: {
  vim = {
    lsp = {
      formatOnSave = true;
      lspkind.enable = false;
      lspsaga.enable = false;
      trouble.enable = true;
      otter-nvim.enable = true;
      lsplines.enable = true;
    };

    autocomplete.blink-cmp.enable = true;
    languages = {
      enableLSP = true;
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      # Nim LSP is broken on Darwin and therefore
      # should be disabled by default. Users may still enable
      # `vim.languages.vim` to enable it, this does not restrict
      # that.
      # See: <https://github.com/PMunch/nimlsp/issues/178#issue-2128106096>

      nix = {
        enable = true;
        lsp = {
          server = "nixd";
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

      markdown = {
        enable = true;
        extensions.render-markdown-nvim.enable = true;
      };

      rust = {
        enable = true;
        crates.enable = false;
      };
    };
  };
}
