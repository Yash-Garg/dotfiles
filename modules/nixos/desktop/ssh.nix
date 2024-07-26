{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  cfg = config.${namespace}.profiles.desktop;
  inherit (lib) mkDefault mkEnableOption mkIf;
in
{
  options.${namespace}.profiles.desktop.ssh = {
    enable = mkEnableOption "Setup SSH";
  };

  config = mkIf cfg.ssh.enable {
    services.openssh = {
      enable = true;
      settings = {
        X11Forwarding = mkDefault true;
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
      openFirewall = true;
    };

    users.users.yash.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILx1G6WZ4MQ8c4hUZy2Be+GF5fZQJSssn4qnJoQ4MPxz"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGT/WxAzpXRNz4AInl2lvZtegbKW0mZxzJjmMcAy1iOx"
    ];
  };
}
