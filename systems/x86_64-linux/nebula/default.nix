{
  config,
  pkgs,
  namespace,
  ...
}:
{
  imports = [ ./wsl.nix ];

  topology.self.name = "WSL";

  time.timeZone = "Asia/Kolkata";

  environment = {
    pathsToLink = [ "/share/zsh" ];
    variables = {
      LANG = "en_US.UTF-8";
    };
  };

  profiles.${namespace}.desktop.ssh.enable = true;

  security.sudo.wheelNeedsPassword = false;

  users = {
    mutableUsers = false;
    users.yash = {
      isNormalUser = true;
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
      extraGroups = [
        "wheel"
        "docker"
      ];
      packages = [ pkgs.wget ];
    };
  };

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  system.stateVersion = "23.11";
}
