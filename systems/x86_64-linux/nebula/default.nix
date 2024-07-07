{
  config,
  pkgs,
  ...
}: {
  wsl = {
    enable = true;
    defaultUser = "yash";
    nativeSystemd = true;
    startMenuLaunchers = true;
    usbip.enable = true;
    wslConf.network.hostname = "nebula";

    # Binaries for Docker Desktop wsl-distro-proxy
    extraBin = with pkgs; [
      {src = "${coreutils}/bin/mkdir";}
      {src = "${coreutils}/bin/cat";}
      {src = "${coreutils}/bin/whoami";}
      {src = "${coreutils}/bin/ls";}
      {src = "${busybox}/bin/addgroup";}
      {src = "${su}/bin/groupadd";}
      {src = "${su}/bin/usermod";}
    ];
  };

  topology.self.name = "WSL";

  time.timeZone = "Asia/Kolkata";

  environment = {
    pathsToLink = ["/share/zsh"];
    variables = {
      LANG = "en_US.UTF-8";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  users.users.yash = {
    isNormalUser = true;
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = ["wheel" "docker"];
    packages = [pkgs.wget];
  };

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  system.stateVersion = "23.11";
}
