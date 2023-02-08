{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "yashgarg";
    homeDirectory = "/home/yashgarg";
  };

  fonts.fontconfig.enable = true;

  targets.genericLinux.enable = true;

  home.file.".imwheelrc".text = ''
    ".*"
    None,      Up,   Button4, 2
    None,      Down, Button5, 2
    Control_L, Up,   Control_L|Button4
    Control_L, Down, Control_L|Button5
    Shift_L,   Up,   Shift_L|Button4
    Shift_L,   Down, Shift_L|Button5
  '';

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

    vscode = {enable = true;};
  };

  systemd.user.services.imwheel = {
    Unit = {
      Description = "systemd service for imwheel";
      Wants = "display-manager.service";
      After = "display-manager.service";
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.imwheel}/bin/imwheel -d";
      ExecStop = "/usr/bin/pkill imwheel";
      RemainAfterExit = "yes";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install = {WantedBy = ["default.target"];};
  };

  home.packages = with pkgs; [
    alejandra
    curl
    fd
    flutter
    htop
    imwheel
    jdk17
    neofetch
    (nerdfonts.override {
      fonts = ["CascadiaCode" "JetBrainsMono"];
    })
    ookla-speedtest
    openrgb
    scrcpy
    tailscale
    unzip
    xclip
    zip
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  home.stateVersion = "22.11";
}
