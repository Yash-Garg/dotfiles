{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.shells.${namespace}.bash;
  profiles = config.profiles.${namespace};
in
{
  options.shells.${namespace}.bash = {
    enable = mkEnableOption "Bash profile";
  };

  config = mkIf cfg.enable {
    programs = {
      bash = enabled // {
        enableCompletion = true;
        historySize = 10000;
        historyFile = "$HOME/.bash_history";
        historyControl = [
          "ignorespace"
          "erasedups"
        ];
        initExtra = "source $HOME/.shell-init";
      };

      atuin.enableBashIntegration = true;
      eza.enableBashIntegration = true;
      fzf.enableBashIntegration = true;
      kitty.shellIntegration.enableBashIntegration = profiles.kitty.enable;
      nix-index.enableBashIntegration = true;
      oh-my-posh.enableBashIntegration = profiles.oh-my-posh.enable;
      starship.enableBashIntegration = profiles.starship.enable;
      wezterm.enableBashIntegration = profiles.wezterm.enable;
      yazi.enableBashIntegration = true;
      zellij.enableBashIntegration = false;
      zoxide.enableBashIntegration = true;
    };
  };
}
