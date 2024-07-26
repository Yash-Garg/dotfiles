{
  config,
  lib,
  namespace,
  ...
}:
let
  cfg = config.${namespace}.services.avahi;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.${namespace}.services.avahi = {
    enable = mkEnableOption "Avahi";
  };

  config = mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
        hinfo = true;
        userServices = true;
        workstation = true;
      };
    };
  };
}
