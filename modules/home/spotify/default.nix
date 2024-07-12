{
  config,
  lib,
  system,
  inputs,
  namespace,
  ...
}: let
  cfg = config.profiles.${namespace}.spotify;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
  inherit (lib) mkEnableOption mkIf;
in {
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
