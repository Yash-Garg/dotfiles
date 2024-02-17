{
  description = "NixOS and Home Manager Configurations";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.devshell-rust.url = "github:Yash-Garg/dotfiles/?dir=shell-configs/rust";
  inputs.devshell-rust.inputs.nixpkgs.follows = "nixpkgs";

  inputs.nix-darwin.url = "github:LnL7/nix-darwin";
  inputs.nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    systems,
    ...
  } @ inputs: let
    eachSystem = nixpkgs.lib.genAttrs (import systems);
    config = {
      allowUnfree = true;
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
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.trinity.pkgs;

    devShells = eachSystem (system: {
      rust = inputs.devshell-rust.devShells.${system}.default;
    });
  };
}
