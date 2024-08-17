{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
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

    gui = mkBoolOpt false "Whether to enable the polychromatic GUI";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.openrazer-daemon ];

    hardware.openrazer = enabled // {
      inherit (cfg) users;
      batteryNotifier.enable = false;
      devicesOffOnScreensaver = false;
      syncEffectsEnabled = false;
    };

    users.users.yash.packages = mkIf cfg.gui [ pkgs.polychromatic ];
  };
}
