{
  config,
  lib,
  ...
}: let
  cfg = config.shells.zsh;
  inherit (lib) mkEnableOption mkIf;
in {
  options.shells.zsh = {
    enable = mkEnableOption "Zsh profile";
  };

  config = mkIf cfg.enable {
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
      oh-my-posh.enableBashIntegration = config.profiles.oh-my-posh.enable;
      starship.enableBashIntegration = config.profiles.starship.enable;
      zoxide.enableZshIntegration = true;
    };
  };
}
