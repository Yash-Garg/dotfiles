{
  config,
  lib,
  namespace,
  ...
}:
let
  cfg = config.profiles.${namespace}.lsd;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [ ./colors.nix ];

  options.profiles.${namespace}.lsd = {
    enable = mkEnableOption "Enable lsd profile";
  };

  config = mkIf cfg.enable {

    programs.lsd = {
      enable = true;
      enableAliases = true;
      settings = {
        date = "relative";
        icons.when = "never";
      };
    };
  };
}
