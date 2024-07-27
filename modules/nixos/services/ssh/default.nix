{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
let
  cfg = config.${namespace}.services.ssh;
in
{
  options.${namespace}.services.ssh = {
    enable = mkEnableOption "Setup SSH";

    keys = mkOption {
      type = types.listOf types.str;
      default = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILx1G6WZ4MQ8c4hUZy2Be+GF5fZQJSssn4qnJoQ4MPxz" ];
      description = "List of SSH keys to add to the authorized_keys file";
    };

    package = mkPackageOption pkgs "openssh" { };

    passwordAuth = mkEnableOption "Allow password authentication";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      package = cfg.package;
      settings = {
        X11Forwarding = mkDefault true;
        PermitRootLogin = "no";
        PasswordAuthentication = mkDefault cfg.passwordAuth;
      };
      openFirewall = true;
    };

    users.users.yash.openssh.authorizedKeys.keys = cfg.keys;
  };
}
