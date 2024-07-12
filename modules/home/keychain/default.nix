{
  config,
  pkgs,
  lib,
  namespace,
  ...
}: let
  cfg = config.profiles.${namespace}.keychain;
  command = "eval `keychain --eval --agents ssh ${cfg.authKey}`";
  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options.profiles.${namespace}.keychain = {
    enable = mkEnableOption "Enable keychain integration";

    authKey = mkOption {
      type = types.str;
      description = "Private ssh key to be added to the ssh-agent";
      default = "$HOME/.ssh/git-ssh";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [pkgs.keychain];

    programs = {
      bash.profileExtra = mkIf config.shells.${namespace}.bash.enable command;
      zsh.profileExtra = mkIf config.shells.${namespace}.zsh.enable command;
    };
  };
}
