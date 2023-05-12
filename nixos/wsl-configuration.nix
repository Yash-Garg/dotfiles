{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "yash";
  home.homeDirectory = "/home/yash";
  targets.genericLinux.enable = true;

  home.file = {
    ".nanorc".text = ''
      set tabsize 4
      set autoindent
      set softwrap
      set nonewlines
      set smarthome
    '';
  };

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      substituters = [
        "https://devenv.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
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
      historyFile = "${config.home.homeDirectory}/.bash_history";
      historyControl = ["ignorespace" "erasedups"];
      shellAliases = {
        cat = "bat";
        cd = "z";
        cls = "clear";
        push = "git push";
        fpush = "git push --force";
        add = "git add --all";
        pull = "git pull";
        st = "git status";
        gcp = "git cherry-pick";
        amend = "git commit --amend";
        commit = "git commit --all -m";
        rst = "git reset; git restore *";
        hs = "home-manager switch";
      };
      profileExtra = ''
        eval `keychain --eval --agents ssh git-ssh`
      '';
      initExtra = ''
        v() {
          file=$(fzf)

          if [ -n "$file" ]; then
            bat $file
          fi
        }

        lg() {
          count=$1

          if [ -z "$count" ]; then
            count=10
          fi

          git log --oneline --decorate --graph --all -n $count
        }

        gdiff() {
          sha=$1

          if [ -z "$sha" ]; then
            sha="HEAD"
          fi

          git diff -w $sha
        }
      '';
    };

    bat = {
      enable = true;
      config = {
        theme = "Catppuccin-mocha";
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
        {path = "${config.home.homeDirectory}/.gitconfig";}
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
        format = "[╭╴](white)$env_var$all[╰─](white)$character";

        cmd_duration = {
          min_time = 0;
        };

        hostname = {
          disabled = false;
          ssh_only = false;
          format = " at [$hostname](bold red) in ";
        };

        nix_shell = {
          symbol = "";
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

  home.packages = with pkgs; [
    alejandra
    cachix
    curl
    delta
    direnv
    fd
    httpie
    inputs.devenv.packages.${pkgs.system}.devenv
    keychain
    neofetch
    neovim
    ookla-speedtest
    ripgrep
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";
}
