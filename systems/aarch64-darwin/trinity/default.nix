{ pkgs, lib, ... }:
{
  users.users.yash = {
    name = "yash";
    home = "/Users/yash";
  };

  environment = {
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      findutils
      gawk
      gnugrep
      gnused
      gnutls
    ];
    systemPath = lib.mkBefore [ "/opt/homebrew/bin" ];
    variables = {
      LANG = "en_US.UTF-8";
    };
  };

  # Add ability to use TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
