{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    fenix,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    overlays = [fenix.overlays.default];
    pkgs = import nixpkgs {
      inherit system overlays;
    };
  in
    with pkgs; {
      devShells.${system}.default = mkShell {
        buildInputs = [
          libressl
          pkg-config
          fenix.packages.${system}.minimalToolchain.override
          {
            withComponents = ["rust-src" "rustfmt"];
            targets = ["x86_64-unknown-linux-gnu" "wasm32-unknown-unknown"];
          }
        ];

        shellHook = ''
          rustc --version
        '';
      };
    };
}
