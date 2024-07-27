{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
let
  cfg = config.${namespace}.services.openrazer;
in
{
  options.${namespace}.services.openrazer = {
    enable = mkEnableOption { description = "Whether to configure openrazer settings"; };

    users = mkOption {
      type = with lib.types; listOf str;
      default = [ "yash" ];
      description = "List of users to add to the openrazer group";
    };
  };

  config = mkIf cfg.enable {
    hardware.openrazer = {
      enable = true;
      users = cfg.users;
      batteryNotifier.enable = false;
      devicesOffOnScreensaver = false;
      syncEffectsEnabled = false;
    };

    users.users.yash.packages = [ pkgs.polychromatic ];
  };
}
