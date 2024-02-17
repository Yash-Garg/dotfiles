{
  config,
  pkgs,
  lib,
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
        theme = "Dracula";
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
      enableBashIntegration = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault false;
      defaultCommand = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git";
      colors = {
        bg = "#282a36";
        "bg+" = "#44475a";
        fg = "#f8f8f2";
        "fg+" = "#f8f8f2";
        hl = "#bd93f9";
        "hl+" = "#bd93f9";
        info = "#ffb86c";
        prompt = "#50fa7b";
        pointer = "#ff79c6";
        marker = "#ff79c6";
        spinner = "#ffb86c";
        header = "#6272a4";
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
      enableBashIntegration = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault false;
    };
  };
}
