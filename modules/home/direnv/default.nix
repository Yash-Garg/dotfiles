{
  config,
  lib,
  namespace,
  ...
}:
with lib.${namespace};
{
  programs.direnv = enabled // {
    enableBashIntegration = config.shells.${namespace}.bash.enable;
    enableZshIntegration = config.shells.${namespace}.zsh.enable;
    nix-direnv = enabled;
    silent = true;
  };
}
