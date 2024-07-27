{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
let
  cfg = config.profiles.${namespace}.obs;
in
{
  options.profiles.${namespace}.obs = {
    enable = mkEnableOption "Enable obs profile";
  };

  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        wlrobs
      ];
    };
  };
}
