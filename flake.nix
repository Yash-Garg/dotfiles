{
  description = "NixOS and Home Manager Configurations";

  inputs = {
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    devshell.inputs.flake-utils.follows = "flake-utils";

    flake-compat.url = "github:nix-community/flake-compat";
    flake-compat.flake = false;

    flake-utils.url = "github:numtide/flake-utils";
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    flake-utils-plus.inputs.flake-utils.follows = "flake-utils";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    lix.url = "git+https://git.lix.systems/lix-project/lix";
    lix.inputs.nixpkgs.follows = "nixpkgs";
    lix.inputs.nixpkgs-regression.follows = "nixpkgs";
    lix.inputs.flake-compat.follows = "flake-compat";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nix-topology.url = "github:oddlama/nix-topology";
    nix-topology.inputs.nixpkgs.follows = "nixpkgs";
    nix-topology.inputs.devshell.follows = "devshell";
    nix-topology.inputs.flake-utils.follows = "flake-utils";

    nixos-wsl.url = "github:getchoo/NixOS-WSL/hardware-graphics";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.flake-compat.follows = "flake-compat";
    nixos-wsl.inputs.flake-utils.follows = "flake-utils";

    nur.url = "github:nix-community/NUR";

    snowfall-lib.url = "github:snowfallorg/lib/dev";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";
    snowfall-lib.inputs.flake-utils-plus.follows = "flake-utils-plus";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.inputs.flake-compat.follows = "flake-compat";

    srvos.url = "github:nix-community/srvos";
    srvos.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.flake-compat.follows = "flake-compat";
    stylix.inputs.home-manager.follows = "home-manager";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    let
      eachSystem = inputs.nixpkgs.lib.genAttrs (import inputs.systems);
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;
        snowfall = {
          namespace = "dots";
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
        cudaSupport = true;
        permittedInsecurePackages = [ "electron-27.3.11" ];
      };

      systems.modules.darwin = with inputs; [
        # srvos.darwinModules.desktop
        srvos.nixosModules.mixins-trusted-nix-caches
      ];

      systems.modules.nixos = with inputs; [
        nix-topology.nixosModules.default
        srvos.nixosModules.common
        srvos.nixosModules.mixins-trusted-nix-caches
        stylix.nixosModules.stylix
      ];

      systems.hosts.nova.modules = with inputs; [ srvos.nixosModules.desktop ];

      systems.hosts.nebula.modules = with inputs; [
        nixos-wsl.nixosModules.default
        srvos.nixosModules.desktop
      ];

      homes.modules = with inputs; [
        nix-index-database.hmModules.nix-index
        spicetify-nix.homeManagerModules.default
      ];

      overlays = with inputs; [
        nix-topology.overlays.default
        nur.overlay
      ];

      outputs-builder = channels: {
        formatter = channels.nixpkgs.nixfmt-rfc-style;

        packages = {
          macbook = inputs.self.darwinConfigurations.trinity.system;
        };

        topology = import inputs.nix-topology {
          pkgs = channels.nixpkgs;
          modules = [
            { inherit (inputs.self) nixosConfigurations; }
            ./topology.nix
          ];
        };
      };

      templates = {
        cpp.description = "devshell for a C++ project";
        go.description = "devshell for a Golang project";
        node.description = "devshell for a Node.js project";
        rust.description = "devshell for a Rust project";
      };
    }
    // { };
}
