{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.profiles.alacritty;
in {
  options.profiles.alacritty = with lib; {
    enable = mkEnableOption "Enable alacritty profile";
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = import ./config.nix;
    };
  };
}
