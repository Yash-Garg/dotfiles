{
  config,
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
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        history = {
          size = 10000;
          path = "$HOME/.zsh_history";
          ignoreDups = true;
        };
        initExtra = "source $HOME/.shell-init";
      };

      atuin.enableZshIntegration = true;
      eza.enableZshIntegration = true;
      fzf.enableZshIntegration = true;
      starship.enableZshIntegration = true;
      zoxide.enableZshIntegration = true;
    };
  };
}
