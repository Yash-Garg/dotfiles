{ lib, namespace, ... }:
with lib.${namespace};
{
  snowfallorg.user = enabled // {
    name = "yash";
  };

  profiles.${namespace}.starship = enabled;

  shells.${namespace}.zsh = enabled;

  home.stateVersion = "24.11";
}
