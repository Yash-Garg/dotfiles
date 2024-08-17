{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib.${namespace};
lib.mkIf pkgs.stdenv.isDarwin {
  programs.direnv = enabled // {
    enableBashIntegration = config.shells.${namespace}.bash.enable;
    enableZshIntegration = config.shells.${namespace}.zsh.enable;
    nix-direnv = enabled;
  };
}
