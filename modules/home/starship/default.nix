{
  config,
  lib,
  inputs,
  namespace,
  ...
}:
let
  cfg = config.profiles.${namespace}.starship;
  palette = builtins.readFile "${inputs.catppuccin-starship}/palettes/mocha.toml";
  settings = builtins.readFile ./config.toml;
  inherit (lib) mkEnableOption mkMerge mkIf;
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
