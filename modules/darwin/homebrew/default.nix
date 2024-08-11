_:
let
  casks = [
    "alt-tab"
    "arc"
    "chatgpt"
    "discord"
    "flutter"
    "iina"
    "imageoptim"
    "jetbrains-toolbox"
    "linear-linear"
    "maccy"
    "raycast"
    "rectangle"
    "spotify"
    "visual-studio-code"
    "wezterm"
  ];
in
{
  homebrew = {
    enable = true;

    brews = [
      "cocoapods"
      "gnu-sed"
      "mongodb-atlas"
      "ruby"
      "xcode-kotlin"
    ];

    casks = map (cask: {
      name = cask;
      greedy = true;
    }) casks;

    caskArgs.appdir = "/Applications";

    global = {
      autoUpdate = false;
      brewfile = true;
    };

    taps = [ ];

    masApps = {
      Amphetamine = 937984704;
      Bitwarden = 1352778147;
      "Prime Video" = 545519333;
      Slack = 803453959;
      Tailscale = 1475387142;
      Telegram = 747648890;
      WhatsApp = 310633997;
    };

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
  };
}
