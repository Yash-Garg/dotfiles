{
  description = "NixOS & Home Manager Configurations";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  inputs.nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.devshell-rust.url = "github:Yash-Garg/dotfiles/?dir=shell-configs/rust";
  inputs.devshell-rust.inputs.nixpkgs.follows = "nixpkgs";

  inputs.nix-darwin.url = "github:LnL7/nix-darwin";
  inputs.nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

  inputs.nur.url = "github:nix-community/NUR";

  inputs.nixos-wsl.url = "github:nix-community/NixOS-WSL";
  inputs.nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

  inputs.nix-index-database.url = "github:Mic92/nix-index-database";
  inputs.nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

 outputs = inputs:
    with inputs; let
    eachSystem = nixpkgs.lib.genAttrs (import systems);
    nixpkgsWithOverlays = with inputs; rec {
        config = {
          allowUnfree = true;
        };
        overlays = [
          nur.overlay
          (_final: prev: {
            # this allows us to reference pkgs.unstable
            unstable = import nixpkgs-unstable {
              inherit (prev) system;
              inherit config;
            };
          })
        ];
      };

      argDefaults = {
        inherit inputs self nix-index-database;
        channels = {
          inherit nixpkgs nixpkgs-unstable;
        };
      };

      configurationDefaults = args: {
        nixpkgs = nixpkgsWithOverlays;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "hm-backup";
        home-manager.extraSpecialArgs = args;
      };

      mkNixosConfiguration = {
        system ? "x86_64-linux",
        hostname,
        username,
        args ? {},
        modules,
      }: let
        specialArgs = argDefaults // {inherit hostname username;} // args;
      in
        nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules =
            [
              (configurationDefaults specialArgs)
              home-manager.nixosModules.home-manager
            ]
            ++ modules;
        };
  in {
    homeConfigurations.wsl = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit config;
        system = "x86_64-linux";
      };

      extraSpecialArgs = {inherit inputs;};

      modules = [
        ./hosts/wsl
        ./hosts/user.nix
      ];
    };

    homeConfigurations.intelbox = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit config;
        system = "x86_64-linux";
      };

      extraSpecialArgs = {inherit inputs;};

      modules = [
        ./hosts/intelbox
        ./hosts/user.nix
      ];
    };

    nixosConfigurations.nova = mkNixosConfiguration {
        hostname = "yash";
        username = "nova";
        modules = [
          nixos-wsl.nixosModules.wsl
          ./hosts/nova
        ];
      };

    darwinConfigurations.trinity = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      pkgs = import nixpkgs {
        inherit config;
        system = "aarch64-darwin";
      };

      specialArgs = {inherit inputs;};

      modules = [
        ./hosts/trinity
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users.yash = import ./hosts/trinity/home.nix;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.trinity.pkgs;

    devShells = eachSystem (system: {
      rust = inputs.devshell-rust.devShells.${system}.default;
    });
  };
}
