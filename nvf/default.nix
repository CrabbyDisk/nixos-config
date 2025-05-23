{
  imports = [
    ./lsp.nix
  ];
  config.vim = {
    viAlias = true;
    vimAlias = true;

    useSystemClipboard = true;

    visuals = {
      nvimWebDevicons.enable = true;
      highlight-undo.enable = true;

      indentBlankline.enable = true;
      rainbow-delimiters.enable = true;

      cursorline = {
        enable = true;
        lineTimeout = 0;
      };
    };

    statusline = {
      lualine = {
        enable = true;
        theme = "catppuccin";
      };
    };

    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
    };

    autopairs.nvim-autopairs.enable = true;

    tabline = {
      nvimBufferline = {
        enable = true;
        mappings = {
          cycleNext = "<leader>bn";
          cyclePrevious = "<leader>bp";
        };
      };
    };

    treesitter.context.enable = true;

    binds = {
      whichKey.enable = true;
    };

    telescope.enable = true;

    notify = {
      nvim-notify.enable = true;
    };

    projects = {
      project-nvim.enable = true;
    };

    utility = {
      ccc.enable = false;
      icon-picker.enable = true;
      surround.enable = true;
      diffview-nvim.enable = true;
    };

    notes = {
      todo-comments.enable = true;
    };

    terminal = {
      toggleterm = {
        enable = true;
        lazygit.enable = true;
      };
    };

    ui = {
      borders.enable = true;
      noice.enable = true;
      colorizer.enable = true;
      modes-nvim.enable = false; # the theme looks terrible with catppuccin
      illuminate.enable = true;
      breadcrumbs = {
        enable = true;
        navbuddy.enable = true;
      };
      smartcolumn = {
        enable = true;
        setupOpts.custom_colorcolumn = {
          # this is a freeform module, it's `buftype = int;` for configuring column position
          nix = "110";
          ruby = "120";
          java = "130";
          go = ["90" "130"];
        };
      };
      fastaction.enable = true;
    };

    session = {
      nvim-session-manager.enable = false;
    };

    comments = {
      comment-nvim.enable = true;
    };

    presence = {
      neocord.enable = true;
    };
  };
}
