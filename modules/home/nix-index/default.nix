{ lib, namespace, ... }:
with lib.${namespace};
{
  programs.nix-index = enabled;
  programs.nix-index-database.comma = enabled;
}
