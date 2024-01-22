{
  config,
  pkgs,
  ...
}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historySize = 10000;
    historyFile = "$HOME/.bash_history";
    historyControl = ["ignorespace" "erasedups"];
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
      nu = "cd $HOME/.config/home-manager; nix flake update; cd $HOME";
      hs = "home-manager switch";
    };
    initExtra = ''
      source $HOME/functions
    '';
  };
}
