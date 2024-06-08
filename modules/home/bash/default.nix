{
  config,
  lib,
  ...
}: let
  cfg = config.shells.bash;
  inherit (lib) mkEnableOption mkIf;
in {
  options.shells.bash = {
    enable = mkEnableOption "Bash profile";
  };

  config = mkIf cfg.enable {
    programs = {
      bash = {
        enable = true;
        enableCompletion = true;
        historySize = 10000;
        historyFile = "$HOME/.bash_history";
        historyControl = ["ignorespace" "erasedups"];
        initExtra = "source $HOME/.shell-init";
      };

      atuin.enableBashIntegration = true;
      eza.enableBashIntegration = true;
      fzf.enableBashIntegration = true;
      starship.enableBashIntegration = true;
      zoxide.enableBashIntegration = true;
    };
  };
}
