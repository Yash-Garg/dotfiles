{
  description = "MacOS Nix Setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nix-darwin,
    home-manager,
    nixpkgs,
    ...
  } @ inputs: {
    darwinConfigurations."Yashs-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      specialArgs = {inherit inputs;};

      modules = [
        ./configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users.yash = import ./home.nix;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Yashs-MacBook-Pro".pkgs;
  };
}
