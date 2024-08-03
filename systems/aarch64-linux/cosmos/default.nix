{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
with lib;
{
  imports = [ ./hardware-configuration.nix ];

  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  age.secrets.tsauthkey.file = snowfall.fs.get-file "secrets/tailscale/cosmos.age";

  boot.initrd.systemd.enableTpm2 = mkForce false;

  dots.services = {
    avahi.enable = true;

    qbittorrent.enable = true;

    samba = {
      enable = true;
      shares = {
        media.path = "/mnt/wd500";
        evo.path = "/mnt/evo970";
      };
    };

    ssh = {
      enable = true;
      package = pkgs.openssh_hpn;
      passwordAuth = true;
    };

    tailscale.enable = true;

    tailscale-autoconnect = {
      enable = true;
      authkeyFile = config.age.secrets.tsauthkey.path;
      extraOptions = [
        "--accept-risk=lose-ssh"
        "--ssh"
        "--advertise-routes=192.168.0.0/24,192.168.1.0/24"
      ];
    };

    jellyfin.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    bluez
    bluez-tools
  ];

  networking = {
    hostName = "cosmos";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        90
        8080
        443
      ];
    };
  };

  topology.self.name = "Raspberry Pi 5";

  users = {
    mutableUsers = false;
    users.yash = {
      isNormalUser = true;
      hashedPassword = "$y$j9T$LIz9rrSiikhg0OqEzMpPc1$2NPu5OfVA6MGiGJHb6V0ZkdYVB6tJhsyTeA6Uq83h86";
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
      extraGroups = [
        "docker"
        "wheel"
      ];
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    oci-containers.containers = {
      glance = {
        image = "glanceapp/glance:latest";
        ports = [ "80:8080" ];
        volumes = [ "${snowfall.fs.get-file "docker/glance/glance.yml"}:/app/glance.yml" ];
        autoStart = true;
      };

      h5ai = {
        image = "awesometic/h5ai:latest";
        ports = [ "90:80" ];
        volumes = [ "/mnt:/h5ai" ];
        autoStart = true;
      };
    };
  };

  system.stateVersion = "24.11";
}
