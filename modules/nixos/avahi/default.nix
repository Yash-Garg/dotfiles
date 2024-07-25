{
  config,
  lib,
  namespace,
  ...
}:
let
  cfg = config.profiles.${namespace}.avahi;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.${namespace}.avahi = {
    enable = mkEnableOption "Avahi profile for mDNS";
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
