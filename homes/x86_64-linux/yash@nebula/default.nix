{ lib, namespace, ... }:
with lib.${namespace};
{
  snowfallorg.user = enabled // {
    name = "yash";
  };

  profiles.${namespace} = {
    atuin = enabled;
    keychain = enabled;
    neovim = enabled;
    oh-my-posh = enabled;
    zellij = enabled;
  };

  shells.${namespace}.zsh = enabled;

  home.stateVersion = "24.11";
}
