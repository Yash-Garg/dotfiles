{
  config,
  lib,
  pkgs,
  namespace,
  ...
}: let
  cfg = config.profiles.${namespace}.samba;
  inherit (lib) mkEnableOption mkIf mkOption;
in {
  options.profiles.${namespace}.samba = {
    enable = mkEnableOption {description = "Whether to configure samba server";};
  };

  config = mkIf cfg.enable {
    services.samba = {
      enable = true;
      package = pkgs.samba;
      securityType = "user";
      openFirewall = true;
      extraConfig = ''
        workgroup = WORKGROUP
        server string = Nova SSHD
        netbios name = INTELBOX
        security = user
        map to guest = bad user
        max log size = 50
      '';
      shares = {
        sshd = {
          path = "/run/media/yash/sshd";
          browseable = "yes";
          writeable = "yes";
          printable = "no";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
        };
      };
    };

    # Advertise shares to Windows hosts
    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };
}
