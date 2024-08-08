{
  config,
  lib,
  namespace,
  ...
}:
with lib;
let
  cfg = config.profiles.${namespace}.alacritty;
in
{
  imports = [ ./settings.nix ];

  options.profiles.${namespace}.alacritty = {
    enable = mkEnableOption "Enable alacritty profile";
  };

  config = mkIf cfg.enable { programs.alacritty.enable = true; };
}
