{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  boot.initrd.systemd.enableTpm2 = lib.mkForce false;
  networking.hostName = "cosmos";
  topology.self.name = "Raspberry Pi 5";

  environment.systemPackages = with pkgs; [
    git
    bluez
    bluez-tools
  ];

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
        hinfo = true;
        userServices = true;
        workstation = true;
      };
    };

    jellyfin = {
      enable = true;
      openFirewall = true;
    };

    openssh = {
      enable = true;
      package = pkgs.openssh_hpn;
    };

    vscode-server.enable = true;
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
