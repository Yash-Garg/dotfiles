{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.services.gitea;
in
{
  options.${namespace}.services.gitea = {
    enable = mkEnableOption { description = "Whether to enable gitea"; };

    openFirewall = mkBoolOpt false "Whether to open the firewall for gitea";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [
      config.services.gitea.settings.server.HTTP_PORT
    ];

    services.gitea = enabled // {
      lfs = enabled;
      settings = {
        actions.ENABLED = false;
        database.type = "sqlite3";
        markdown.ENABLE_MATH = true;
        server = {
          DOMAIN = "git.turtle-lake.ts.net";
          SSH_PORT = 1123;
          HTTP_PORT = 3001;
          ROOT_URL = "https://git.turtle-lake.ts.net";
        };
        service = {
          DISABLE_REGISTRATION = true;
          REGISTER_MANUAL_CONFIRM = true;
          REQUIRE_SIGNIN_VIEW = true;
        };
      };
    };
  };
}
