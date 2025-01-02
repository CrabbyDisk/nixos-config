{
  nixpkgs,
  nvf,
  ...
}:
nvf.lib.neovimConfiguration {
  modules = [./config];
  inherit nixpkgs;
}
