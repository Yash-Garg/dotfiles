{
  pkgs,
  inputs,
  ...
}: {
  imports = [../modules/nix];

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
