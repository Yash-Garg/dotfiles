{
  config,
  lib,
  ...
}: let
  cfg = config.profiles.starship;
  settings = builtins.readFile ./config.toml;
  inherit (lib) mkEnableOption mkIf;
in {
  options.profiles.starship = {
    enable = mkEnableOption "Enable starship profile";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = builtins.fromTOML settings;
    };
  };
}
