{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  boot.initrd.systemd.enableTpm2 = lib.mkForce false;
  networking.hostName = "cosmos";
  topology.self.name = "Raspberry Pi 5";

  environment.systemPackages = with pkgs; [
    git
    bluez
    bluez-tools
  ];

  dots.services = {
    avahi.enable = true;

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

    jellyfin.enable = true;
  };

  services = {
    openssh = {
      enable = true;
      package = pkgs.openssh_hpn;
    };

    vscode-server.enable = true;
  };

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
