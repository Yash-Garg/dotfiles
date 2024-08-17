{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
{
  imports = [ ./hardware-configuration.nix ];

  age.secrets.passwordfile-cosmos.file = snowfall.fs.get-file "secrets/cosmos/user.age";
  age.secrets.tsauthkey.file = snowfall.fs.get-file "secrets/cosmos/tailscale.age";

  boot.initrd.systemd.enableTpm2 = mkForce false;

  dots = {
    hardware.networking = enabled // {
      extra = false;
      hostName = "cosmos";
      tcpPorts = [
        80
        90
        443
      ];
    };

    services = {
      avahi = enabled;

      qbittorrent = enabled;

      samba = enabled // {
        shares = {
          media.path = "/mnt/wd500";
          evo.path = "/mnt/evo970";
        };
      };

      ssh = enabled // {
        package = pkgs.openssh_hpn;
        passwordAuth = true;
      };

      tailscale = enabled // {
        authKeyFile = config.age.secrets.tsauthkey.path;
        extraOptions = [
          "--accept-risk=lose-ssh"
          "--advertise-exit-node"
          "--advertise-routes=192.168.0.0/24,192.168.1.0/24"
          "--ssh"
        ];
      };

      jellyfin = enabled;
    };

    virtualisation = enabled;
  };

  environment.systemPackages = with pkgs; [
    git
    bluez
    bluez-tools
  ];

  topology.self.name = "Raspberry Pi 5";

  users = {
    mutableUsers = false;
    users.yash = {
      isNormalUser = true;
      passwordFile = config.age.secrets.passwordfile-cosmos.path;
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
      extraGroups = [
        "docker"
        "wheel"
      ];
    };
  };

  virtualisation.oci-containers.containers = {
    h5ai = {
      image = "awesometic/h5ai:latest";
      ports = [ "80:80" ];
      volumes = [ "/mnt:/h5ai" ];
      autoStart = true;
    };
  };

  system.stateVersion = "24.11";
}
