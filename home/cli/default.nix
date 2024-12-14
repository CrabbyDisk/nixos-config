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
    nushell.enable = true;
    mpv = {
      enable = true;
      profiles = {
        music = {
          profile-cond = "(audio and not video)";
          audio-display = "no";
          audio-samplerate = 48000;
        };
      };
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
