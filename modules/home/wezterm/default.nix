{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
let
  cfg = config.profiles.${namespace}.wezterm;
in
{
  options.profiles.${namespace}.wezterm = {
    enable = mkEnableOption "Enable wezterm, a GPU-accelerated terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      package = pkgs.wezterm;
      extraConfig = mkMerge [
        (builtins.readFile ./config/utils.lua)
        (builtins.readFile ./config/wezterm.lua)
      ];
    };
  };
}
