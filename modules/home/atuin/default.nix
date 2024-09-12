{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.profiles.${namespace}.atuin;
in
{
  options.profiles.${namespace}.atuin = {
    enable = mkEnableOption "Enable atuin profile";
  };

  config = mkIf cfg.enable {
    programs.atuin = enabled // {
      flags = [ "--disable-up-arrow" ];
      settings = {
        max_preview_height = 2;
        search_mode = "skim";
        show_preview = true;
        style = "compact";
      };
    };
  };
}
