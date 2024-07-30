{
  description = "devshell for a C++ project";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  inputs.devshell.url = "github:numtide/devshell";
  inputs.devshell.inputs.nixpkgs.follows = "nixpkgs";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs.flake-compat.url = "github:nix-community/flake-compat";
  inputs.flake-compat.flake = false;

  outputs =
    {
      nixpkgs,
      devshell,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlays.default ];
        };
      in
      {
        devShells.default = pkgs.devshell.mkShell {
          bash = {
            interactive = "";
          };

          env = [
            {
              name = "DEVSHELL_NO_MOTD";
              value = 1;
            }
          ];

          packages = with pkgs; [
            clang_13
            clang-tools
            cmake
            just
            lld_13
            pkg-config
          ];
        };
      }
    );
}
