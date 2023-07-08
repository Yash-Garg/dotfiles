{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    rust-overlay,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        overlays = [rust-overlay.overlays.default];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        toolchain = pkgs.rust-bin.fromRustupToolchainFile ./toolchain.toml;
      in
        with pkgs; {
          devShells.default = mkShell {
            buildInputs = [
              libressl
              pkg-config
              toolchain
            ];

            shellHook = ''
              rustc --version
            '';
          };
        }
    );
}
