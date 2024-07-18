{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
let
  cfg = config.profiles.${namespace}.alacritty;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [ ./settings.nix ];

  options.profiles.${namespace}.alacritty = {
    enable = mkEnableOption "Enable alacritty profile";
  };

  config = mkIf cfg.enable { programs.alacritty.enable = true; };
}
