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
  options.profiles.${namespace}.alacritty = {
    enable = mkEnableOption "Enable alacritty profile";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = import ./config.nix { inherit lib pkgs; };
    };
  };
}
