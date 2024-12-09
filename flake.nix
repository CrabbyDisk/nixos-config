{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    #nvf
    nvf.url = "github:crabbydisk/nvf-config";
    nvf.inputs.nixpkgs.follows = "nixpkgs";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    #Zen browser

    zen-browser.url = "github:MarceColl/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # Plasma Manager
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = ["x86_64-linux"];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager

    homeConfigurations."crabbydisk" = home-manager.lib.homeManagerConfiguration {
      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [./home/home.nix];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix

      pkgs = import nixpkgs {system = "x86_64-linux";};
    };

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      good-pc = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main nixos configuration file <
          ./system/configuration.nix
        ];
      };
    };
  };
}
