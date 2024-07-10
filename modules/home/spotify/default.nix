{
  config,
  lib,
  system,
  inputs,
  ...
}: let
  cfg = config.profiles.spotify;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
  inherit (lib) mkEnableOption mkIf;
in {
  options.profiles.spotify = {
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
