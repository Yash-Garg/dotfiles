{
  config,
  lib,
  namespace,
  ...
}:
let
  cfg = config.shells.${namespace}.zsh;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.shells.${namespace}.zsh = {
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
      oh-my-posh.enableZshIntegration = config.profiles.${namespace}.oh-my-posh.enable;
      starship.enableZshIntegration = config.profiles.${namespace}.starship.enable;
      wezterm.enableZshIntegration = config.profiles.${namespace}.wezterm.enable;
      zoxide.enableZshIntegration = true;
    };
  };
}
