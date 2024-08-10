{ config, ... }:
{
  system = {
    defaults = {
      CustomUserPreferences = {
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };

        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
        };

        NSGlobalDomain = {
          AppleActionOnDoubleClick = "Minimize";
        };
      };

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
        # Disable all hot corners
        wvous-tl-corner = 1;
        wvous-bl-corner = 1;
        wvous-tr-corner = 1;
        wvous-br-corner = 1;
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

      loginwindow = {
        GuestEnabled = false;
      };

      NSGlobalDomain = {
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.trackpad.forceClick" = true;
        AppleInterfaceStyle = "Dark";
        AppleScrollerPagingBehavior = true;
        AppleWindowTabbingMode = "always";
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
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
      };
    };

    startup.chime = true;
  };
}
