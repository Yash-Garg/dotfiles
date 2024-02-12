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
      initExtra = "source $HOME/.functions";
      shellAliases = {
        cat = "bat";
        cd = "z";
        cls = "clear";
        push = "git push";
        fpush = "git push --force";
        add = "git add --all";
        pull = "git pull --rebase";
        st = "git status";
        gcp = "git cherry-pick";
        amend = "git commit --amend";
        commit = "git commit --all -m";
        rst = "git reset; git restore *";
        hs = "home-manager switch";
      };
    };
  };
}
