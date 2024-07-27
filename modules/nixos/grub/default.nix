{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
let
  cfg = config.${namespace}.profiles.grub;
in
{
  options.${namespace}.profiles.grub = {
    enable = mkEnableOption "Enable the GRUB bootloader";
  };

  config = mkIf cfg.enable {
    boot.loader.grub = {
      enable = lib.mkDefault true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
      gfxmodeEfi = "2560x1440";
      backgroundColor = "#000000";
      fontSize = 36;
      splashImage = ../desktop/images/background.png;
      font = "${pkgs.source-code-pro}/share/fonts/opentype/SourceCodePro-Medium.otf";
    };
  };
}
