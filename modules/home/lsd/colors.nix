_: {
  # https://github.com/hardhackerlabs/theme-lsd/blob/master/hardhacker.yaml
  programs.lsd.colors = {
    user = "cyan";
    group = "yellow";
    permission = {
      read = "green";
      write = "yellow";
      exec = "red";
      exec-sticky = "magenta";
      no-access = "dark_grey";
    };
    date = {
      hour-old = "grey";
      day-old = "grey";
      older = "dark_grey";
    };
    size = {
      none = "green";
      small = "green";
      medium = "green";
      large = "green";
    };
    inode = {
      valid = "blue";
      invalid = "dark_grey";
    };
    links = {
      valid = "blue";
      invalid = "dark_grey";
    };
    tree-edge = "dark_grey";
  };
}
