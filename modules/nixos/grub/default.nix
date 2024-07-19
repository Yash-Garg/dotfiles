{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  cfg = config.profiles.${namespace}.grub;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.${namespace}.grub = {
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
