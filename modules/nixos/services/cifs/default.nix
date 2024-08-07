{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.cifs;
  cifsShare = path: {
    device = "//${path}";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [ "${automount_opts},credentials=/etc/nixos/smb-secrets" ];
  };
in
{
  options.${namespace}.services.cifs = {
    enable = mkEnableOption "CIFS Shares Auto-Mounting";

    cifsHost = mkOption {
      type = types.str;
      default = "nova";
      description = "The key name for cifs credentials";
    };

    mounts = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            path = mkOption {
              type = types.str;
              description = "The CIFS share path in the format <hostname>/<share>.";
            };
          };
        }
      );
      default = { };
      description = "List of CIFS shares to be mounted.";
    };
  };

  config = mkIf cfg.enable {
    age.secrets.cifs-creds.file = snowfall.fs.get-file "secrets/cifs/${cfg.cifsHost}.age";

    environment.etc."nixos/smb-secrets".source = config.age.secrets.cifs-creds.path;
    environment.etc."nixos/smb-secrets".mode = "0600";
    environment.systemPackages = [ pkgs.cifs-utils ];

    fileSystems = listToAttrs (
      mapAttrsToList (name: mount: {
        name = "/mnt/${name}";
        value = cifsShare mount.path;
      }) cfg.mounts
    );
  };
}
