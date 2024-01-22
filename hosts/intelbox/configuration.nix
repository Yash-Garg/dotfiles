{
  config,
  pkgs,
  ...
}: {
  targets.genericLinux.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    apktool
    flutter
    google-chrome
    imwheel
    jdk17
    jetbrains-toolbox
    kitty
    (nerdfonts.override {
      fonts = ["CascadiaCode" "JetBrainsMono"];
    })
    scrcpy
    telegram-desktop
    vscode
    xclip
  ];

  systemd.user.services.optimise-nix-store = {
    Unit = {Description = "nix store maintenance";};

    Service = {
      CPUSchedulingPolicy = "idle";
      IOSchedulingClass = "idle";
      ExecStart = toString (pkgs.writeShellScript "nix-optimise-store" ''
        ${pkgs.nix}/bin/nix-collect-garbage -d
        ${pkgs.nix}/bin/nix store gc
        ${pkgs.nix}/bin/nix store optimise
      '');
    };
  };

  systemd.user.timers.optimise-nix-store = {
    Unit.Description = "nix store maintenance";
    Timer.OnCalendar = "weekly";
    Install.WantedBy = ["timers.target"];
  };
}
