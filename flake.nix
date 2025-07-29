{
  description = "Advanced example of Nix-on-Droid system config with home-manager.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixvim.url = "github:nix-community/nixvim";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, home-manager, nix-on-droid, nix-index-database, nixvim, catppuccin }: {

    nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
      modules = [
        ./nix-on-droid.nix
        #nixvim.homeModules.nixvim

        # list of extra modules for Nix-on-Droid system
        { nix.registry.nixpkgs.flake = nixpkgs; }
        # ./path/to/module.nix

        # or import source out-of-tree modules like:
        # flake.nixOnDroidModules.module
      ];

      # list of extra special args for Nix-on-Droid modules
      extraSpecialArgs = {
        # rootPath = ./.;
        inherit nix-index-database nixvim catppuccin;
      };

      # set nixpkgs instance, it is recommended to apply `nix-on-droid.overlays.default`
      pkgs = import nixpkgs {
        system = "aarch64-linux";

        overlays = [
          nix-on-droid.overlays.default
          # add other overlays
        ];
      };

      # set path to home-manager flake
      home-manager-path = home-manager.outPath;
    };

  };
}
