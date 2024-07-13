{
  config,
  lib,
  namespace,
  ...
}:
let
  cfg = config.shells.${namespace}.bash;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.shells.${namespace}.bash = {
    enable = mkEnableOption "Bash profile";
  };

  config = mkIf cfg.enable {
    programs = {
      bash = {
        enable = true;
        enableCompletion = true;
        historySize = 10000;
        historyFile = "$HOME/.bash_history";
        historyControl = [
          "ignorespace"
          "erasedups"
        ];
        initExtra = "source $HOME/.shell-init";
      };

      atuin.enableBashIntegration = true;
      eza.enableBashIntegration = true;
      fzf.enableBashIntegration = true;
      oh-my-posh.enableBashIntegration = config.profiles.${namespace}.oh-my-posh.enable;
      starship.enableBashIntegration = config.profiles.${namespace}.starship.enable;
      zoxide.enableBashIntegration = true;
    };
  };
}
