{
  description = "NixOS and Home Manager Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    devshell.inputs.flake-utils.follows = "flake-utils";

    flake-utils.url = "github:numtide/flake-utils";

    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    flake-utils-plus.inputs.flake-utils.follows = "flake-utils";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nix-topology.url = "github:oddlama/nix-topology";
    nix-topology.inputs.nixpkgs.follows = "nixpkgs";
    nix-topology.inputs.devshell.follows = "devshell";
    nix-topology.inputs.flake-utils.follows = "flake-utils";

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

      systems.modules.nixos = with inputs; [
        nix-topology.nixosModules.default
      ];

      homes.modules = with inputs; [
        nix-index-database.hmModules.nix-index
      ];

      overlays = with inputs; [
        nix-topology.overlays.default
      ];

      deploy = lib.mkDeploy {inherit (inputs) self;};

      outputs-builder = channels: {
        topology = import inputs.nix-topology {
          pkgs = channels.nixpkgs;
          modules = [
            {inherit (inputs.self) nixosConfigurations;}
            ./topology.nix
          ];
        };
      };
    }
    // {
      templates = {
        cpp = {
          description = "devshell for a C++ project";
          path = ./templates/cpp;
        };

        go = {
          description = "devshell for a Golang project";
          path = ./templates/go;
        };

        rust = {
          description = "devshell for a Rust project";
          path = ./templates/rust;
        };
      };
    }
    // {
      packages.aarch64-darwin.macbook = inputs.self.darwinConfigurations.trinity.system;
    };
}
