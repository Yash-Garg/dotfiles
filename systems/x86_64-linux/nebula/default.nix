{
  config,
  pkgs,
  namespace,
  ...
}:
{
  dots.system.wsl.enable = true;
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
