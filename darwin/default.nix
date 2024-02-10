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

  environment.pathsToLink = [
    "/share/zsh"
  ];

  fonts.fontDir.enable = true;

  nixpkgs.config.allowUnfree = true;

  homebrew = {
    enable = true;
    brews = [
      "cocoapods"
      "gnu-sed"
      "ruby"
    ];
    casks = ["flutter"];
    taps = [];
    masApps = {
      "Adguard for Safari" = 1440147259;
      "Prime Video" = 545519333;
      "Telegram" = 747648890;
    };
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
      ssl-cert-file = /private/etc/ssl/cert.pem
      extra-nix-path = nixpkgs=flake:nixpkgs
    '';
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  environment.systemPackages = with pkgs; [
    discord
    iina
    iterm2
    raycast
    rectangle
    slack
    spotify
    vscode
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
