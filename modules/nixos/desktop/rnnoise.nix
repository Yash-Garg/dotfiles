{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
let
  cfg = config.${namespace}.profiles.desktop;
  noise-suppression-for-voice = pkgs.writeTextDir "share/pipewire/pipewire.conf.d/99-noise-cancellation.conf" ''
    context.modules = [
    {   name = libpipewire-module-filter-chain
        args = {
            node.description =  "Noise Canceling source"
            media.name =  "Noise Canceling source"
            filter.graph = {
                nodes = [
                    {
                        type = ladspa
                        name = rnnoise
                        plugin = ${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so
                        label = noise_suppressor_mono
                        control = {
                            "VAD Threshold (%)" = 50.0
                        }
                    }
                ]
            }
            capture.props = {
                node.name =  "effect_input.rnnoise"
                node.passive = true
                audio.rate = 48000
            }
            playback.props = {
                node.name =  "effect_output.rnnoise"
                media.class = Audio/Source
                audio.rate = 48000
            }
        }
    }
    ]
  '';
in
{
  options.${namespace}.profiles.desktop.noise-cancellation = {
    enable = mkEnableOption "Enable noise cancellation in PipeWire";
  };

  config = mkIf cfg.noise-cancellation.enable {
    services.pipewire.configPackages = [ noise-suppression-for-voice ];
  };
}
