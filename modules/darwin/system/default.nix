{ config, ... }:
{
  system = {
    defaults = {
      dock = {
        autohide = false;
        largesize = 110;
        magnification = true;
        mineffect = "scale";
        minimize-to-application = false;
        orientation = "bottom";
        persistent-apps =
          let
            brewAppDir = config.homebrew.caskArgs.appdir;
            homeAppDir = "${config.users.users.yash.home}/Applications";
          in
          [
            "${brewAppDir}/iTerm.app"
            "${brewAppDir}/Linear.app"
            "${brewAppDir}/Xcode.app"
            "${brewAppDir}/ChatGPT.app"
            "${brewAppDir}/Visual Studio Code.app"
            "${brewAppDir}/Discord.app"
            "${brewAppDir}/Spotify.app"
            "${homeAppDir}/Android Studio.app"
            "${brewAppDir}/Arc.app"
            "${brewAppDir}/WhatsApp.app"
            "${brewAppDir}/Slack.app"
            "${brewAppDir}/Telegram.app"
          ];
        show-recents = false;
        tilesize = 35;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        _FXShowPosixPathInTitle = false;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        QuitMenuItem = false;
        ShowPathbar = true;
        ShowStatusBar = true;
      };

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        InitialKeyRepeat = 15;
        KeyRepeat = 1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };

      trackpad = {
        Clicking = true;
      };
    };

    startup.chime = true;
  };
}
