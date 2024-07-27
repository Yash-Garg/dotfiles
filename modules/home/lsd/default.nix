{
  config,
  lib,
  namespace,
  ...
}:
with lib;
let
  cfg = config.profiles.${namespace}.lsd;
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
