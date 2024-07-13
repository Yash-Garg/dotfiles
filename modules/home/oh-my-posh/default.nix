{
  config,
  lib,
  namespace,
  ...
}:
let
  cfg = config.profiles.${namespace}.oh-my-posh;
  ompConfig = builtins.readFile ./config.omp.json;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.${namespace}.oh-my-posh = {
    enable = mkEnableOption "Enable oh-my-posh profile";
  };

  config = mkIf cfg.enable {
    programs.oh-my-posh = {
      enable = true;
      settings = builtins.fromJSON ompConfig;
    };
  };
}
