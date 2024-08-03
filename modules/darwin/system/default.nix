_: {
  system = {
    defaults = {
      dock = {
        autohide = false;
        largesize = 110;
        magnification = true;
        mineffect = "scale";
        minimize-to-application = false;
        orientation = "bottom";
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
