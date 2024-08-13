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
in
{
  imports = [ ./hardware-configuration.nix ];

  age.secrets.passwordfile-vortex.file = snowfall.fs.get-file "secrets/users/${hostName}.age";
  age.secrets.tsauthkey.file = snowfall.fs.get-file "secrets/tailscale/${hostName}.age";
  age.secrets.tsauthkey-env.file = snowfall.fs.get-file "secrets/tailscale/${hostName}-env.age";

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
