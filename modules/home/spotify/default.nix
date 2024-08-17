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
  cfg = config.profiles.${namespace}.spotify;
in
{
  options.profiles.${namespace}.spotify = {
    enable = mkEnableOption "Enable Spotify";
  };

  config = mkIf cfg.enable {
    programs.spicetify = enabled // {
      theme = pkgs.spicetify.themes.catppuccin;
      colorScheme = "mocha";
      enabledExtensions = with pkgs.spicetify.extensions; [
        hidePodcasts
        lastfm
      ];
    };
  };
}
