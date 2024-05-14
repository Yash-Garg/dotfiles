{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.profiles.mpv;
in {
  options.profiles.mpv = with lib; {
    enable = mkEnableOption "Enable mpv profile";
  };

  config = lib.mkIf cfg.enable {
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
