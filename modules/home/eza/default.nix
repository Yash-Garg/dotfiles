{ lib, namespace, ... }:
with lib.${namespace};
{
  programs.eza = enabled // {
    icons = false;
    extraOptions = [ "--all" ];
  };
}
