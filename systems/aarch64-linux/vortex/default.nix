{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  hostName = "vortex";
in
{
  imports = [ ./hardware-configuration.nix ];

  age.secrets.passwordfile-vortex.file = snowfall.fs.get-file "secrets/users/${hostName}.age";
  age.secrets.tsauthkey.file = snowfall.fs.get-file "secrets/tailscale/${hostName}.age";

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  networking = {
    domain = "";
    inherit hostName;
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
        authKeyFile = config.age.secrets.tsauthkey.path;
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
    hashedPasswordFile = config.age.secrets.passwordfile-vortex.path;
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "24.05";
}
