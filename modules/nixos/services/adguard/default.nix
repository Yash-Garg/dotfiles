{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.adguard;
in
{
  options.${namespace}.services.adguard = {
    enable = mkEnableOption "Adguard Home Server";
  };

  config = mkIf cfg.enable {
    services.adguardhome = enabled // {
      mutableSettings = true;
      openFirewall = true;
      port = 3001;
    };
  };
}
