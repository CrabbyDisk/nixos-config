{lib, ...}: {
  programs = {
    starship = {
      enable = true;
    };

    zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };

    bottom = {
      enable = true;
      settings.flags.process_memory_as_value = true;
    };

    yazi = {
      enable = true;
      settings = {
        manager.show_hidden = true;
      };
    };
    nushell.enable = true;

    mpv = {
      enable = true;
      profiles = {
        music = {
          profile-cond = "(audio and not video)";
          audio-display = "no";
          audio-samplerate = 48000;
          gapless-audio = "weak";
        };
      };
    };

    yt-dlp.enable = true;

    git = {
      enable = true;
      signing.format = "openpgp";
      userEmail = "crabbydisk@proton.me";
      userName = "crabbydisk";
    };

    gh = {
      enable = true;
      settings = {
        editor = "nvim";
        git_protocol = "https";
      };
    };
  };
}
