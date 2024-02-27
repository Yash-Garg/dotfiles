{lib, ...}: {
  programs.zoxide = {
    enable = true;
    enableBashIntegration = lib.mkDefault true;
    enableZshIntegration = lib.mkDefault false;
  };
}
