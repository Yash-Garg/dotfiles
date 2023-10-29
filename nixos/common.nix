{
  config,
  pkgs,
  ...
}: {
  home.file = {
    ".nanorc".text = ''
      set tabsize 4
      set autoindent
      set softwrap
      set nonewlines
      set smarthome
    '';

    ".gitconfig".source =
      pkgs.fetchFromGitHub {
        owner = "Yash-Garg";
        repo = "dotfiles";
        rev = "b298edde1266edad3a8125ef147904ba5505ce73";
        sha256 = "sha256-tuIeZlPb97wAN71i+JfQ5EohniiNMcuI/enzrkY+mAI=";
      }
      + "/.gitconfig";

    "functions.sh" = {
      executable = true;
      source =
        pkgs.fetchFromGitHub {
          owner = "Yash-Garg";
          repo = "dotfiles";
          rev = "b298edde1266edad3a8125ef147904ba5505ce73";
          sha256 = "sha256-tuIeZlPb97wAN71i+JfQ5EohniiNMcuI/enzrkY+mAI=";
        }
        + "/functions.sh";
    };
  };

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
    extraOptions = "experimental-features = nix-command flakes";
  };

  programs = {
    bash = {
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
        . $HOME/functions.sh
      '';
    };

    bat = {
      enable = true;
      themes = {
        catppuccin-mocha = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
            sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
          };
          file = "Catppuccin-mocha.tmTheme";
        };
      };
      config = {
        theme = "catppuccin-mocha";
        pager = "never";
      };
    };

    btop = {
      enable = true;
      settings = {
        color_theme = "${pkgs.btop}/share/btop/themes/dracula.theme";
        theme_background = false;
      };
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
      defaultCommand = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git";
      colors = {
        bg = "#1e1e2e";
        "bg+" = "#313244";
        fg = "#cdd6f4";
        "fg+" = "#cdd6f4";
        hl = "#f38ba8";
        "hl+" = "#f38ba8";
        header = "#f38ba8";
        info = "#cba6f7";
        marker = "#f5e0dc";
        pointer = "#f5e0dc";
        prompt = "#cba6f7";
        spinner = "#f5e0dc";
      };
    };

    git = {
      enable = true;
      includes = [
        {path = "$HOME/.gitconfig";}
      ];
    };

    home-manager = {enable = true;};

    jq = {enable = true;};

    lsd = {
      enable = true;
      enableAliases = true;
      settings = {
        icons.when = "never";
      };
    };

    starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        add_newline = true;
        command_timeout = 10000;

        cmd_duration = {
          min_time = 0;
        };

        hostname = {
          disabled = false;
          ssh_only = false;
          format = " at [$hostname](bold red) in ";
        };

        nix_shell = {
          symbol = "nix";
          format = "via [$symbol-$state]($style) ";
        };

        username = {
          show_always = true;
          format = "[$user]($style)";
        };

        gradle.disabled = true;
        java.disabled = true;
        kotlin.disabled = true;
      };
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
  };

  systemd.user.services.optimise-nix-store = {
    Unit = {Description = "nix store maintenance";};

    Service = {
      CPUSchedulingPolicy = "idle";
      IOSchedulingClass = "idle";
      ExecStart = toString (pkgs.writeShellScript "nix-optimise-store" ''
        ${pkgs.nix}/bin/nix-collect-garbage -d
        ${pkgs.nix}/bin/nix store gc
        ${pkgs.nix}/bin/nix store optimise
      '');
    };
  };

  systemd.user.timers.optimise-nix-store = {
    Unit.Description = "nix store maintenance";
    Timer.OnCalendar = "weekly";
    Install.WantedBy = ["timers.target"];
  };

  home.packages = with pkgs; [
    alejandra
    cachix
    curl
    delta
    direnv
    fd
    httpie
    neofetch
    ripgrep
    unzip
    zip
  ];
}
