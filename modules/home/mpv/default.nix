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
        mpv-playlistmanager
        sponsorblock
      ];
    };
  };
}
