{
  config,
  lib,
  ...
}: let
  cfg = config.profiles.lsd;
  inherit (lib) mkEnableOption mkIf;
in {
  options.profiles.lsd = {
    enable = mkEnableOption "Enable lsd profile";
  };

  config = mkIf cfg.enable {
    programs.lsd = {
      enable = true;
      enableAliases = true;
      colors = import ./colors.nix;
      settings = {
        date = "relative";
        icons.when = "never";
      };
    };
  };
}
