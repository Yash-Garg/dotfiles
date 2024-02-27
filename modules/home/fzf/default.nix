{lib, ...}: {
  programs.fzf = {
    enable = true;
    enableBashIntegration = lib.mkDefault true;
    enableZshIntegration = lib.mkDefault false;
    defaultCommand = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git";
    colors = {
      bg = "#282a36";
      "bg+" = "#44475a";
      fg = "#f8f8f2";
      "fg+" = "#f8f8f2";
      hl = "#bd93f9";
      "hl+" = "#bd93f9";
      info = "#ffb86c";
      prompt = "#50fa7b";
      pointer = "#ff79c6";
      marker = "#ff79c6";
      spinner = "#ffb86c";
      header = "#6272a4";
    };
  };
}
