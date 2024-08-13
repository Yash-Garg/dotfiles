{ lib, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  age.secrets.samba-passwd.file = lib.snowfall.fs.get-file "secrets/nova/samba.age";

  dots = {
    desktop = {
      enable = true;
      extraPackages = [ ];
      gnome.enable = true;
    };

    hardware.networking.hostName = "nova";

    services = {
      cifs = {
        enable = true;
        cifsHost = "nova";
        mounts = {
          evo.path = "cosmos.local/evo";
          wd.path = "cosmos.local/media";
        };
      };

      samba = {
        enable = true;
        shares = {
          downloads.path = "/mnt/sshd";
        };
      };
    };

    system.boot.secure.enable = true;
  };

  topology.self.name = "Desktop";

  users.users.yash = {
    isNormalUser = true;
    description = "Yash Garg";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
