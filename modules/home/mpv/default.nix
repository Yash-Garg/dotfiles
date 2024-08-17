{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.profiles.${namespace}.mpv;
in
{
  imports = [ ./config.nix ];

  options.profiles.${namespace}.mpv = {
    enable = mkEnableOption "Enable mpv profile";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.jellyfin-mpv-shim ];

    programs.mpv = enabled // {
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
        scripts =
          with pkgs.${namespace};
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
        autoload = {
          disabled = false;
          images = false;
          videos = true;
          audio = true;
          ignore_hidden = true;
        };
        uosc = {
          buffered_time_threshold = 600;
          controls = "menu,gap,subtitles,<has_many_audio>audio,<has_many_video>video,<has_many_edition>editions,<stream>stream-quality,gap,space,play-pause,space,gap,fullscreen";
          controls_persistency = "paused,idle";
          font_bold = true;
          scale_fullscreen = 1.1;
          stream_quality_options = "";
          timeline_persistency = "paused,idle";
          timeline_style = "bar";
          top_bar_alt_title = "\${filename}";
          top_bar_persistency = "paused,idle";
          volume = "left";
        };
      };
    };

    xdg.configFile = {
      "mpv/shaders".source =
        let
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
