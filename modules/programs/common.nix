{
  config,
  pkgs,
  ...
}: {
  programs = {
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

    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
