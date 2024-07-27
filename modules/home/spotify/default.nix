{
  config,
  lib,
  system,
  inputs,
  namespace,
  ...
}:
with lib;
let
  cfg = config.profiles.${namespace}.spotify;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
in
{
  options.profiles.${namespace}.spotify = {
    enable = mkEnableOption "Enable Spotify";
  };

  config = mkIf cfg.enable {
    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
      enabledExtensions = with spicePkgs.extensions; [
        hidePodcasts
        lastfm
      ];
    };
  };
}
