{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
let
  hostName = "vortex";
  get-secret = name: snowfall.fs.get-file "secrets/${hostName}/${name}.age";
in
{
  imports = [ ./hardware-configuration.nix ];

  age.secrets = {
    passwordfile-vortex.file = get-secret "user";
    feed-auth.file = get-secret "miniflux.env";
    tsauthkey.file = get-secret "tailscale";
    tsauthkey-env.file = get-secret "caddy.env";
  };

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  networking = {
    domain = "";
    inherit hostName;
  };

  dots = {
    services = {
      ssh = {
        enable = true;
        addRootKeys = true;
        passwordAuth = false;
        permitRootLogin = true;
      };

      tailscale = {
        enable = true;
        authKeyFile = config.age.secrets.tsauthkey.path;
        extraOptions = [
          "--accept-risk=lose-ssh"
          "--advertise-exit-node"
          "--advertise-routes=192.168.0.0/24,192.168.1.0/24"
          "--ssh"
        ];
      };
    };

    virtualisation.enable = true;
  };

  services.caddy = {
    enable = true;
    package = pkgs.${namespace}.caddy-tailscale;
    virtualHosts = {
      "https://glance.turtle-lake.ts.net" = {
        extraConfig = ''
          bind tailscale/glance
          tailscale_auth
          reverse_proxy :90
        '';
      };
      "https://miniflux.turtle-lake.ts.net" = {
        extraConfig = ''
          bind tailscale/miniflux
          tailscale_auth
          reverse_proxy :8889
        '';
      };
    };
  };

  services.miniflux = {
    enable = true;
    adminCredentialsFile = config.age.secrets.feed-auth.path;
    createDatabaseLocally = true;
    config = {
      LISTEN_ADDR = "127.0.0.1:8889";
      FETCH_ODYSEE_WATCH_TIME = 1;
      FETCH_YOUTUBE_WATCH_TIME = 1;
      LOG_DATE_TIME = 1;
      LOG_FORMAT = "json";
      WORKER_POOL_SIZE = 2;
      BASE_URL = "https://miniflux.turtle-lake.ts.net/";
      HTTPS = 1;
      METRICS_COLLECTOR = 1;
      WEBAUTHN = 1;
    };
  };

  systemd.services.caddy = {
    serviceConfig = {
      EnvironmentFile = [ config.age.secrets.tsauthkey-env.path ];
    };
  };

  users.users.yash = {
    isNormalUser = true;
    hashedPasswordFile = config.age.secrets.passwordfile-vortex.path;
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = [ "wheel" ];
  };

  virtualisation.oci-containers.containers = {
    glance = {
      image = "glanceapp/glance:latest";
      ports = [ "90:8080" ];
      volumes = [ "${snowfall.fs.get-file "docker/glance/glance.yml"}:/app/glance.yml" ];
      autoStart = true;
    };
  };

  system.stateVersion = "24.05";
}
