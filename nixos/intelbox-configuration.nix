{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "yashgarg";
    homeDirectory = "/home/yashgarg";
  };

  programs = {
    aria2 = {enable = true;};

    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        cls = "clear";
        ls = "ls --color=auto";
        ll = "ls -l";
        la = "ls -A";
        l = "ls -CF";
        push = "git push";
        fpush = "git push --force";
        amend = "git commit --amend - S";
        add = "git add --all";
        pull = "git pull";
        st = "git status";
        commit = "git commit --all -m";
      };
    };

    bat = {
      enable = true;
      config = {
        theme = "Dracula";
      };
    };

    home-manager = {enable = true;};

    htop = {enable = true;};

    git = {enable = true;};

    starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        add_newline = true;
        command_timeout = 1000;

        cmd_duration = {
          min_time = 0;
        };

        username = {
          show_always = true;
        };
      };
    };
  };

  home.packages = with pkgs; [
    alejandra
    curl
    fd
    neofetch
    ookla-speedtest
    unzip
    zip
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  home.stateVersion = "22.11";
}
