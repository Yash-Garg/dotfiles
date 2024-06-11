{pkgs, ...}: {
  snowfallorg.user = {
    enable = true;
    name = "yash";
  };

  profiles.oh-my-posh.enable = true;

  shells.zsh.enable = true;

  home.packages = with pkgs; [
    apktool
    (nerdfonts.override {
      fonts = ["CascadiaCode" "JetBrainsMono"];
    })
    scrcpy
  ];

  home.stateVersion = "23.11";
}
