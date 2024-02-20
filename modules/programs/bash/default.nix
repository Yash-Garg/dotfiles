{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.shells;
in {
  options.shells.bash = {
    enable = lib.mkEnableOption "bash shell";
  };

  config = lib.mkIf cfg.bash.enable {
    programs.bash = {
      enable = true;
      enableCompletion = true;
      historySize = 10000;
      historyFile = "$HOME/.bash_history";
      historyControl = ["ignorespace" "erasedups"];
      initExtra = "source $HOME/.shell-init";
    };
  };
}
