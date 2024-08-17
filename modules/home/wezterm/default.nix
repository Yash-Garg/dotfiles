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
  configs = builtins.readDir ./config;
in
{
  options.profiles.${namespace}.wezterm = {
    enable = mkEnableOption "Enable wezterm, a GPU-accelerated terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.wezterm = enabled // {
      package = pkgs.wezterm;
      extraConfig = map (name: builtins.readFile ./config/${name}) (attrNames configs);
    };
  };
}
