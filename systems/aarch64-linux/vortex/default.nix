{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  boot.tmp.cleanOnBoot = true;

  dots.services = {
    ssh = {
      enable = true;
      package = pkgs.openssh_hpn;
      addRootKeys = true;
      permitRootLogin = true;
    };

    tailscale = {
      enable = true;
      extraOptions = [
        "--accept-risk=lose-ssh"
        "--advertise-exit-node"
        "--advertise-routes=192.168.0.0/24,192.168.1.0/24"
        "--ssh"
      ];
    };
  };

  zramSwap.enable = true;

  networking = {
    domain = "";
    hostName = "vortex";
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
