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

  boot.initrd.systemd.enableTpm2 = mkForce false;

  dots.services = {
    avahi.enable = true;

    qbittorrent.enable = true;

    samba = {
      enable = true;
      shares = {
        media = {
          path = "/mnt/wd500/media";
          browseable = "yes";
          writeable = "yes";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
        };
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
      authkeyFile = config.sops.secrets.tsauthkey.path;
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

  networking.hostName = "cosmos";

  sops.age.sshKeyPaths = lib.mkForce [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.gnupg.sshKeyPaths = lib.mkForce [ ];
  sops.secrets.tsauthkey = {
    sopsFile = snowfall.fs.get-file "secrets/tailscale.yaml";
  };

  topology.self.name = "Raspberry Pi 5";

  users = {
    mutableUsers = false;
    users.yash = {
      isNormalUser = true;
      hashedPassword = "$y$j9T$LIz9rrSiikhg0OqEzMpPc1$2NPu5OfVA6MGiGJHb6V0ZkdYVB6tJhsyTeA6Uq83h86";
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
      extraGroups = [ "wheel" ];
    };
  };

  system.stateVersion = "24.11";
}
