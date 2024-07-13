{
  config,
  lib,
  namespace,
  ...
}:
let
  cfg = config.profiles.${namespace}.starship;
  settings = builtins.readFile ./config.toml;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.${namespace}.starship = {
    enable = mkEnableOption "Enable starship profile";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = builtins.fromTOML settings;
    };
  };
}
