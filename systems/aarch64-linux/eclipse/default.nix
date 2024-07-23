{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
{
  boot.initrd.systemd.enableTpm2 = lib.mkForce false;
  boot.loader.systemd-boot.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    git
    bluez
    bluez-tools
    wirelesstools
  ];

  hardware = {
    bluetooth.enable = true;
    raspberry-pi.config = {
      all = {
        base-dt-params = {
          krnbt = {
            enable = true;
            value = "on";
          };
        };
      };
    };
  };

  networking = {
    hostName = "eclipse";
    useDHCP = true;
    firewall = {
      allowedTCPPorts = [
        80
        443
      ];
    };
    interfaces = {
      wlan0.useDHCP = true;
    };
  };

  services.openssh = {
    enable = true;
    package = pkgs.openssh_hpn;
  };

  time.timeZone = "Asia/Kolkata";

  topology.self.name = "Raspberry Pi 5";

  users = {
    mutableUsers = false;
    users.yash = {
      isNormalUser = true;
      initialPassword = "123456";
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
      extraGroups = [ "wheel" ];
    };
    users.root.openssh.authorizedKeys.keys = [
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILx1G6WZ4MQ8c4hUZy2Be+GF5fZQJSssn4qnJoQ4MPxz''
    ];
  };

  system.stateVersion = "23.11";
}
