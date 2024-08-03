_: {
  i18n =
    let
      locale = "en_US.UTF-8";
    in
    {
      defaultLocale = locale;
      extraLocaleSettings = {
        LC_ALL = locale;
      };
    };
}
