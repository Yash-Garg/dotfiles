{ lib, namespace, ... }:
with lib.${namespace};
{
  snowfallorg.user = enabled // {
    name = "yash";
  };

  profiles.${namespace} = {
    keychain = enabled;
    oh-my-posh = enabled;
    zellij = enabled;
  };

  shells.${namespace}.zsh = enabled;

  home.stateVersion = "24.11";
}
