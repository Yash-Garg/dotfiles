{
  description = "Home Manager Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell-rust = {
      url = "github:Yash-Garg/dotfiles/?dir=shell-configs/rust";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
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
        ./hosts/wsl/configuration.nix
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
        ./hosts/intelbox/configuration.nix
        ./hosts/user.nix
      ];
    };

    devShells = eachSystem (system: {
      rust = inputs.devshell-rust.devShells.${system}.default;
    });
  };
}
