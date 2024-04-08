{
  env = {
    TERM = "screen-256color";
  };

  # Colors (Aura Theme)
  colors = {
    primary = {
      background = "#15141b";
      foreground = "#edecee";
    };

    cursor = {
      cursor = "#a277ff";
    };

    selection = {
      text = "CellForeground";
      background = "#29263c";
    };

    normal = {
      black = "#110f18";
      red = "#ff6767";
      green = "#61ffca";
      yellow = "#ffca85";
      blue = "#a277ff";
      magenta = "#a277ff";
      cyan = "#61ffca";
      white = "#edecee";
    };

    bright = {
      black = "#4d4d4d";
      red = "#ff6767";
      green = "#61ffca";
      yellow = "#ffca85";
      blue = "#a277ff";
      magenta = "#a277ff";
      cyan = "#61ffca";
      white = "#edecee";
    };
  };

  font = {
    size = 13;

    normal = {
      family = "CaskaydiaCove Nerd Font Mono";
      style = "Regular";
    };

    bold = {
      family = "CaskaydiaCove Nerd Font Mono";
      style = "Bold";
    };
  };

  window = {
    dimensions = {
      columns = 160;
      lines = 45;
    };

    padding = {
      x = 16;
      y = 0;
    };
  };
}
