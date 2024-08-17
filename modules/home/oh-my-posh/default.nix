{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.profiles.${namespace}.oh-my-posh;
  ompConfig = builtins.readFile ./config.omp.json;
in
{
  options.profiles.${namespace}.oh-my-posh = {
    enable = mkEnableOption "Enable oh-my-posh profile";
  };

  config = mkIf cfg.enable {
    programs.oh-my-posh = enabled // {
      settings = builtins.fromJSON ompConfig;
    };
  };
}
