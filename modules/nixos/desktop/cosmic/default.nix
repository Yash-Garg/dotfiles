{
  config,
  lib,
  namespace,
  ...
}:
with lib;
let
  cfg = config.${namespace}.desktop.cosmic;
in
{
  options.${namespace}.desktop.cosmic = {
    enable = mkEnableOption "Setup desktop with Cosmic DE";
  };

  config = mkIf cfg.enable {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
  };
}
