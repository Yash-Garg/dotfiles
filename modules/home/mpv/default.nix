{
  config,
  pkgs,
  lib,
  namespace,
  ...
}: let
  cfg = config.profiles.mpv;
  inherit (lib) mkEnableOption mkIf;
in {
  options.profiles.mpv = {
    enable = mkEnableOption "Enable mpv profile";
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      config = import ./config.nix;
      bindings = {
        BS = "cycle pause";
        SPACE = "cycle pause";
        UP = "add volume 2";
        DOWN = "add volume -2";
        b = "cycle audio";
        v = "cycle sub";
      };
      package = pkgs.mpv-unwrapped.wrapper {
        mpv = pkgs.mpv-unwrapped.override {
          ffmpeg = pkgs.ffmpeg-full;
          lua = pkgs.luajit;
        };
        scripts = with pkgs.${namespace};
          [
            auto-profiles
            better-chapters
            boss-key
            repl
            status-line
          ]
          ++ (with pkgs.mpvScripts; [
            acompressor
            autocrop
            autoload
            mpv-playlistmanager
            reload
            uosc
          ]);
      };
      scriptOpts = {
        osc = {
          deadzonesize = 0.75;
          scalewindowed = 0.85;
          scalefullscreen = 0.95;
          scaleforcedwindow = 1.5;
          boxmaxchars = 140;
          boxalpha = 100;
        };
        uosc = {};
      };
    };

    xdg.configFile = {
      "mpv/shaders".source = let
        fsrcnnx-x2-16-0-4-1 = pkgs.fetchurl {
          url = "https://github.com/igv/FSRCNN-TensorFlow/releases/download/1.1/FSRCNNX_x2_16-0-4-1.glsl";
          sha256 = "sha256-1aJKJx5dmj9/egU7FQxGCkTCWzz393CFfVfMOi4cmWU=";
        };
        fsrcnnx-x2-8-0-4-1 = pkgs.fetchurl {
          url = "https://github.com/igv/FSRCNN-TensorFlow/releases/download/1.1/FSRCNNX_x2_8-0-4-1.glsl";
          sha256 = "sha256-6ADbxcHJUYXMgiFsWXckUz/18ogBefJW7vYA8D6Nwq4=";
        };
        ssimdownscaler = pkgs.fetchurl {
          url = "https://gist.githubusercontent.com/igv/36508af3ffc84410fe39761d6969be10/raw/575d13567bbe3caa778310bd3b2a4c516c445039/SSimDownscaler.glsl";
          sha256 = "sha256-AEq2wv/Nxo9g6Y5e4I9aIin0plTcMqBG43FuOxbnR1w=";
        };
        krigbilateral = pkgs.fetchurl {
          url = "https://gist.githubusercontent.com/igv/a015fc885d5c22e6891820ad89555637/raw/038064821c5f768dfc6c00261535018d5932cdd5/KrigBilateral.glsl";
          sha256 = "sha256-ikeYq7d7g2Rvzg1xmF3f0UyYBuO+SG6Px/WlqL2UDLA=";
        };
      in
        pkgs.stdenvNoCC.mkDerivation {
          name = "mpv-shaders";
          dontUnpack = true;

          buildPhase = ''
            runHook preBuild

            mkdir -p $out
            cp ${fsrcnnx-x2-16-0-4-1} $out/${fsrcnnx-x2-16-0-4-1.name}
            cp ${fsrcnnx-x2-8-0-4-1} $out/${fsrcnnx-x2-8-0-4-1.name}
            cp ${ssimdownscaler} $out/${ssimdownscaler.name}
            cp ${krigbilateral} $out/${krigbilateral.name}

            runHook postBuild
          '';
        };
    };
  };
}
