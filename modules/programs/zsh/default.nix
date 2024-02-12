{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.shells;
in {
  options.shells.zsh = {
    enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Enable zsh";
    };
  };

  config = lib.mkIf cfg.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      history = {
        size = 10000;
        path = "$HOME/.zsh_history";
        ignoreDups = true;
      };
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
        gw = "./gradlew";
      };
    };
  };
}
