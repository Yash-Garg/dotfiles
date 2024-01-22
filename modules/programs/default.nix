{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common.nix
    ./bash
    ./starship
  ];
}
