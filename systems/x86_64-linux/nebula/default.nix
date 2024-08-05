{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
with lib;
{
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  age.secrets.tsauthkey.file = snowfall.fs.get-file "secrets/tailscale/nebula.age";

  dots = {
    system.wsl = {
      enable = true;
      hostname = "nebula";
    };

    services = {
      ssh.enable = true;

      tailscale.enable = true;

      tailscale-autoconnect = {
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
  };

  security.sudo.wheelNeedsPassword = false;
  topology.self.name = "WSL";

  environment = {
    pathsToLink = [ "/share/zsh" ];
    variables = {
      LANG = "en_US.UTF-8";
    };
  };

  users.users.yash = {
    isNormalUser = true;
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = [
      "wheel"
      "docker"
    ];
    packages = [ pkgs.wget ];
  };

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  system.stateVersion = "24.11";
}
