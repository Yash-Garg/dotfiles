{
  config,
  lib,
  namespace,
  ...
}:
let
  cfg = config.${namespace}.services.jellyfin;
  inherit (lib) mkEnableOption mkIf;
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
