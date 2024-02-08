{
  pkgs,
  inputs,
  ...
}: {
  users.users.yash = {
    name = "yash";
    home = "/Users/yash";
  };

  environment.variables = {
    LANG = "en_US.UTF-8";
  };

  fonts = {
    fontDir.enable = true;
  };

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = ["yash" "root"];
    };
    extraOptions = ''
      experimental-features = nix-command flakes repl-flake
      max-jobs = auto
      ssl-cert-file = /private/etc/ssl/cert.pem
      extra-nix-path = nixpkgs=flake:nixpkgs
    '';
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
