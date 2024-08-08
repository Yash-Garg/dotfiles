{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  age.secrets.tsauthkey.file = lib.snowfall.fs.get-file "secrets/tailscale/vortex.age";

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  networking = {
    domain = "";
    hostName = "vortex";
  };

  dots = {
    services = {
      ssh = {
        enable = true;
        addRootKeys = true;
        passwordAuth = false;
        permitRootLogin = true;
      };

      tailscale = {
        enable = true;
        authkeyFile = config.age.secrets.tsauthkey.path;
        extraOptions = [
          "--accept-risk=lose-ssh"
          "--advertise-exit-node"
          "--advertise-routes=192.168.0.0/24,192.168.1.0/24"
          "--ssh"
        ];
      };
    };

    virtualisation.enable = true;
  };

  users.users.yash = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$LIz9rrSiikhg0OqEzMpPc1$2NPu5OfVA6MGiGJHb6V0ZkdYVB6tJhsyTeA6Uq83h86";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "24.05";
}
