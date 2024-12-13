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
    gh = {
      enable = true;
      settings.editor = "nvim";
    };
  };
}
