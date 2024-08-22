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
let
  driverPkg = config.boot.kernelPackages.nvidiaPackages.production.bin;
in
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    extraModulePackages = [ ];
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [
      "kvm-intel"
      "i2c-dev"
    ];
  };

  hardware.i2c = enabled;

  # Enable OpenGL
  hardware.graphics = enabled // {
    enable32Bit = true;
    package = driverPkg;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting = enabled;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement = disabled // {
      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      finegrained = false;
    };

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = driverPkg;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/3a260301-7f2c-43e1-8ec8-59caa9c38d23";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/03EC-2AF2";
    fsType = "vfat";
  };

  fileSystems."/mnt/sshd" = {
    device = "/dev/disk/by-uuid/7838708038703F66";
    fsType = "ntfs";
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/29c26536-b342-4c31-bf42-10614bfc61fd"; } ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
