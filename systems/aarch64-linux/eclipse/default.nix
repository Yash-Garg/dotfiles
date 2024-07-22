{
  config,
  pkgs,
  namespace,
  ...
}:
{
  boot.initrd.systemd.enableTpm2 = false;

  hardware = {
    bluetooth.enable = true;
    raspberry-pi = {
      config = {
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
  };

  networking = {
    hostName = "eclipse";
    useDHCP = false;
    interfaces = {
      wlan0.useDHCP = true;
    };
  };

  profiles.${namespace}.desktop.ssh.enable = true;

  time.timeZone = "Asia/Kolkata";

  users.users.yash = {
    isNormalUser = true;
    initialPassword = "123456";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = [
      "wheel"
      "docker"
      "libvirtd"
    ];
    packages = with pkgs; [
      bluez
      bluez-tools
    ];
  };

  system.stateVersion = "23.11";
}
