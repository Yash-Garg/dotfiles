{ lib, namespace, ... }:
with lib;
with lib.${namespace};
{
  # `install-iso` adds wireless support that
  # is incompatible with networkmanager.
  networking.wireless.enable = mkForce false;

  dots = {
    desktop = {
      gnome = enabled;
      stylix = enabled;
    };

    hardware = {
      audio = enabled;
      bluetooth = enabled;
      networking = enabled;
    };

    services = {
      printing = enabled;
      ssh = enabled;
    };

    system = {
      boot = enabled;
      xkb = enabled;
    };
  };

  users.users.yash = {
    group = "users";
    isNormalUser = true;
  };

  system.stateVersion = "24.11";
}
