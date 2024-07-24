{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
{
  boot.initrd.systemd.enableTpm2 = lib.mkForce false;

  topology.self.name = "Raspberry Pi 5";

  environment.systemPackages = with pkgs; [
    git
    bluez
    bluez-tools
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
    interfaces = {
      wlan0.useDHCP = true;
    };
  };

  services.openssh = {
    enable = true;
    package = pkgs.openssh_hpn;
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

  system.stateVersion = "24.05";
}
