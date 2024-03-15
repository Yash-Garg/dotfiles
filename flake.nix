{
  description = "NixOS and Home Manager Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    devshell-rust.url = "github:Yash-Garg/dotfiles/?dir=shell-configs/rust";
    devshell-rust.inputs.nixpkgs.follows = "nixpkgs";

    devshell-go.url = "github:Yash-Garg/dotfiles/?dir=shell-configs/go";
    devshell-go.inputs.nixpkgs.follows = "nixpkgs";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    flake-utils-plus.inputs.flake-utils.follows = "flake-utils";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    snowfall-lib.url = "github:snowfallorg/lib/dev";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";
    snowfall-lib.inputs.flake-utils-plus.follows = "flake-utils-plus";
  };

  outputs = inputs: let
    eachSystem = inputs.nixpkgs.lib.genAttrs (import inputs.systems);
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;
      snowfall = {
        meta = {
          name = "yash-nix-configs";
          title = "Yash's Nix configurations";
        };
      };
    };
  in
    lib.mkFlake {
      inherit inputs;
      src = ./.;

      channels-config = {
        allowUnfree = true;
      };

      homes.modules = with inputs; [
        nix-index-database.hmModules.nix-index
      ];

      deploy = lib.mkDeploy {inherit (inputs) self;};
    }
    // {
      packages.aarch64-darwin.macbook = inputs.self.darwinConfigurations.trinity.system;

      devShells = eachSystem (system: {
        go = inputs.devshell-go.devShells.${system}.default;
        rust = inputs.devshell-rust.devShells.${system}.default;
      });
    };
}
