{
  config,
  lib,
  namespace,
  ...
}:
let
  cfg = config.profiles.${namespace}.jellyfin;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.${namespace}.jellyfin = {
    enable = mkEnableOption "Jellyfin server profile";
  };

  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
