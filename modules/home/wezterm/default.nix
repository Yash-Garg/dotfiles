{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.profiles.${namespace}.wezterm;
in
{
  options.profiles.${namespace}.wezterm = {
    enable = mkEnableOption "Enable wezterm, a GPU-accelerated terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.wezterm = enabled // {
      package = pkgs.wezterm;
      extraConfig = mkMerge [
        (builtins.readFile ./config/utils.lua)
        (builtins.readFile ./config/wezterm.lua)
      ];
    };
  };
}
