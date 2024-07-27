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
  cfg = config.${namespace}.services.qbittorrent;
  configDir = "/var/lib/qbittorrent";
in
{
  options.${namespace}.services.qbittorrent = {
    enable = mkBoolOpt false "Enable qbittorrent-nox service.";

    user = mkOption {
      type = types.str;
      default = "qbittorrent";
      description = "The user which qbittorrent will run on";
    };

    group = mkOption {
      type = types.str;
      default = "qbittorrent";
      description = "The group of the user which qbittorrent will run on";
    };

    openFirewall = mkBoolOpt true "Open the firewall for qbittorrent";

    port = mkOption {
      type = types.int;
      default = 3000;
      description = "The port for the webui";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.qbittorrent ];

    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.port ];
      allowedUDPPorts = [ cfg.port ];
    };

    systemd.services.qbittorrent = {
      after = [ "network.target" ];
      description = "qBittorrent Daemon";
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.qbittorrent ];
      serviceConfig = {
        ExecStart = ''
          ${pkgs.qbittorrent}/bin/qbittorrent-nox \
            --profile=${configDir} \
            --webui-port=${toString cfg.port}
        '';
        Restart = "on-success";
        User = cfg.user;
        Group = cfg.group;
        UMask = "0002";
      };
    };

    users.users = mkIf (cfg.user == "qbittorrent") {
      qbittorrent = {
        inherit (cfg) group;
        home = configDir;
        createHome = true;
        description = "qBittorrent Daemon user";
        isNormalUser = true;
      };
    };

    users.groups = mkIf (cfg.group == "qbittorrent") {
      qbittorrent = {
        gid = null;
      };
    };
  };
}
