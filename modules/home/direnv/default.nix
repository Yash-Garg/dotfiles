{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
lib.mkIf (pkgs.stdenv.isDarwin) {
  programs.direnv = {
    enable = true;
    enableBashIntegration = config.shells.${namespace}.bash.enable;
    enableZshIntegration = config.shells.${namespace}.zsh.enable;
    nix-direnv.enable = true;
  };
}
