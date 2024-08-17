{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.virtualisation;
in
{
  options.${namespace}.virtualisation = with types; {
    enable = mkBoolOpt false "Whether or not to enable virtualisation support";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      docker = enabled // {
        rootless = enabled // {
          setSocketVariable = true;
        };
      };

      oci-containers.backend = "docker";
    };
  };
}
