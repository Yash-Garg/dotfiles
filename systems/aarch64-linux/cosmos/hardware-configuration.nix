# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  namespace,
  modulesPath,
  ...
}:
with lib.${namespace};
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    extraModulePackages = [ ];
    initrd.availableKernelModules = [ ];
    initrd.kernelModules = [ ];
    kernelModules = [ ];
    kernelParams = [
      "8250.nr_uarts=11"
      "console=ttyAMA10,9600"
      "console=tty0"
    ];
  };

  hardware = {
    bluetooth = enabled;
    raspberry-pi.config = {
      pi5 = {
        dt-overlays = {
          vc4-kms-v3d-pi5 = enabled // {
            params = { };
          };
        };
      };
      all = {
        base-dt-params = {
          krnbt = enabled // {
            value = "on";
          };
        };
      };
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  fileSystems."/boot/firmware" = {
    device = "/dev/disk/by-label/FIRMWARE";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  fileSystems."/mnt/wd500" = {
    device = "/dev/disk/by-uuid/ec2f35a7-a498-451f-b0c9-1d6677023277";
    fsType = "ext4";
    options = [
      "nofail"
      "rw"
    ];
  };

  fileSystems."/mnt/evo970" = {
    device = "/dev/disk/by-uuid/382ba8fb-7d26-4b71-b59c-667f87566853";
    fsType = "ext4";
    options = [
      "nofail"
      "rw"
    ];
  };

  raspberry-pi-nix.board = "bcm2712";

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
