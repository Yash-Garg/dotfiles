{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.profiles.mpv;
  inherit (lib) mkEnableOption mkIf;
in {
  options.profiles.mpv = {
    enable = mkEnableOption "Enable mpv profile";
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      bindings = import ./bindings.nix;
      config = import ./config.nix;
      scripts = with pkgs.mpvScripts; [
        acompressor
        autocrop
        autoload
        mpv-playlistmanager
        reload
        sponsorblock
      ];
      scriptOpts = {
        osc = {
          deadzonesize = 0.75;
          scalewindowed = 0.85;
          scalefullscreen = 0.95;
          scaleforcedwindow = 1.5;
          boxmaxchars = 140;
          boxalpha = 100;
        };
      };
    };
  };
}
