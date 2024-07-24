# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.kernelParams = [
    "8250.nr_uarts=11"
    "console=ttyAMA10,9600"
    "console=tty0"
  ];
  boot.extraModulePackages = [ ];

  hardware = {
    bluetooth.enable = true;
    raspberry-pi.config = {
      pi5 = {
        dt-overlays = {
          vc4-kms-v3d-pi5 = {
            enable = true;
            params = { };
          };
        };
      };
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

  fileSystems."/" = {
    device = "/dev/root";
    fsType = "ext4";
  };

  fileSystems."/boot/firmware" = {
    device = "/dev/disk/by-uuid/2178-694E";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  fileSystems."/mnt/media" = {
    device = "/dev/disk/by-uuid/6bf02424-40c6-4966-9fb1-9d5d2b071a8a";
    fsType = "ext4";
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.wlan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
