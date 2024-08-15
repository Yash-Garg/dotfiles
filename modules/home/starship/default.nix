{
  config,
  lib,
  inputs,
  namespace,
  ...
}:
with lib;
let
  cfg = config.profiles.${namespace}.starship;
  palette = builtins.readFile "${inputs.catppuccin-starship}/themes/mocha.toml";
  settings = builtins.readFile ./config.toml;
in
{
  options.profiles.${namespace}.starship = {
    enable = mkEnableOption "Enable starship profile";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = mkMerge [
        (builtins.fromTOML settings)
        (builtins.fromTOML palette)
      ];
    };
  };
}
