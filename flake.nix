{
  description = "Home Manager Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell-rust = {
      url = "github:Yash-Garg/dotfiles/?dir=nixos/shell-configs/rust";
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

      modules = [./nixos/wsl-configuration.nix];
    };

    homeConfigurations.intelbox = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit config;
        system = "x86_64-linux";
      };

      extraSpecialArgs = {inherit inputs;};

      modules = [./nixos/intelbox-configuration.nix];
    };

    devShells = eachSystem (system: {
      rust = inputs.devshell-rust.devShells.${system}.default;
    });
  };
}
