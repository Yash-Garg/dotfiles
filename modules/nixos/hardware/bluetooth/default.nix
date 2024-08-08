{
  config,
  lib,
  namespace,
  ...
}:
with lib;
let
  cfg = config.${namespace}.hardware.bluetooth;
in
{
  options.${namespace}.hardware.bluetooth = {
    enable = mkEnableOption "Profile for bluetooth hardware";
  };

  config = mkIf cfg.enable { hardware.bluetooth.enable = mkDefault true; };
}
