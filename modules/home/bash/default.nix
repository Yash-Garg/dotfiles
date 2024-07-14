{
  config,
  lib,
  namespace,
  ...
}:
let
  cfg = config.shells.${namespace}.bash;
  profiles = config.profiles.${namespace};
  inherit (lib) mkEnableOption mkIf;
in
{
  options.shells.${namespace}.bash = {
    enable = mkEnableOption "Bash profile";
  };

  config = mkIf cfg.enable {
    programs = {
      bash = {
        enable = true;
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
      oh-my-posh.enableBashIntegration = profiles.oh-my-posh.enable;
      starship.enableBashIntegration = profiles.starship.enable;
      wezterm.enableBashIntegration = profiles.wezterm.enable;
      zoxide.enableBashIntegration = true;
    };
  };
}
