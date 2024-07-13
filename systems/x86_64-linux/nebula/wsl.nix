{ config, pkgs, ... }:
{
  wsl = {
    enable = true;
    defaultUser = "yash";
    nativeSystemd = true;
    startMenuLaunchers = true;
    usbip.enable = true;
    wslConf.network.hostname = "nebula";

    # Binaries for Docker Desktop wsl-distro-proxy
    extraBin = with pkgs; [
      { src = "${coreutils}/bin/mkdir"; }
      { src = "${coreutils}/bin/cat"; }
      { src = "${coreutils}/bin/whoami"; }
      { src = "${coreutils}/bin/ls"; }
      { src = "${busybox}/bin/addgroup"; }
      { src = "${su}/bin/groupadd"; }
      { src = "${su}/bin/usermod"; }
    ];
  };
}
