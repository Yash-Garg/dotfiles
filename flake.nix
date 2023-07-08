{
  description = "Home Manager Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell-rust = {
      url = "path:./nixos/shell-configs/rust";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    config = {
      allowUnfree = true;
    };
  in {
    homeConfigurations.server = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit config;
        system = "aarch64-linux";
      };

      modules = [./nixos/server-configuration.nix];
    };

    homeConfigurations.intelbox = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit config;
        system = "x86_64-linux";
      };

      modules = [./nixos/intelbox-configuration.nix];
    };

    homeConfigurations.wsl = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit config;
        system = "x86_64-linux";
      };

      extraSpecialArgs = {inherit inputs;};

      modules = [./nixos/wsl-configuration.nix];
    };

    devShells.x86_64-linux = {
      rust = inputs.devshell-rust.devShells.x86_64-linux.default;
    };
  };
}
