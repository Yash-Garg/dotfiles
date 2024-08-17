{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.cosmic;
in
{
  options.${namespace}.desktop.cosmic = {
    enable = mkEnableOption "Setup desktop with Cosmic DE";
  };

  config = mkIf cfg.enable {
    services.desktopManager.cosmic = enabled;
    services.displayManager.cosmic-greeter = enabled;
  };
}
