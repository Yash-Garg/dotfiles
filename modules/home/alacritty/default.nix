{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.profiles.alacritty;
  inherit (lib) mkEnableOption mkIf;
in {
  options.profiles.alacritty = {
    enable = mkEnableOption "Enable alacritty profile";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = import ./config.nix;
    };
  };
}
