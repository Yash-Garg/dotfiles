{
  config,
  lib,
  namespace,
  ...
}:
with lib;
let
  cfg = config.${namespace}.services.jellyfin;
in
{
  options.${namespace}.services.jellyfin = {
    enable = mkEnableOption "Jellyfin server profile";
  };

  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
