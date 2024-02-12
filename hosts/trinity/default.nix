{
  pkgs,
  inputs,
  ...
}: let
  fetchTarballFromGitHub = {
    repo,
    owner,
    rev,
    sha256,
  }:
    fetchTarball {
      url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
      inherit sha256;
    };

  nur-pkgs = import (fetchTarballFromGitHub {
    owner = "nrabulinski";
    repo = "nur-packages";
    rev = "b19fe09dd3f325ff2731b83f230e2573b67db4aa";
    sha256 = "sha256:134k789wq2ard19y7grwqmqbk888j30qa9d4wz27jrlnk650yzzj";
  }) {inherit pkgs;};
in {
  users.users.yash = {
    name = "yash";
    home = "/Users/yash";
  };

  environment = {
    pathsToLink = ["/share/zsh"];
    variables = {
      LANG = "en_US.UTF-8";
    };
  };

  fonts.fontDir.enable = true;

  homebrew = {
    enable = true;
    brews = [
      "cocoapods"
      "gnu-sed"
      "ruby"
    ];
    casks = [
      "flutter"
    ];
    taps = [];
    masApps = {
      "Adguard for Safari" = 1440147259;
      "Pandan" = 1569600264;
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
    alt-tab-macos
    discord
    iina
    iterm2
    maccy
    raycast
    rectangle
    slack
    spotify
    nur-pkgs.transmission-bin
    vscode
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
