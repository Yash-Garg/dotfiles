{
  # General
  profile = "gpu-hq";
  vo = "gpu-next";
  gpu-api = "vulkan";
  vd-lavc-dr = true;
  spirv-compiler = "auto";
  vulkan-async-compute = true;
  vulkan-async-transfer = true;
  vulkan-queue-count = 1;
  hwdev = "nvdec";
  video-sync = "display-resample";

  # Resizers
  scale = "ewa_lanczos";
  dscale = "ewa_lanczos";
  cscale = "sinc";
  cscale-window = "blackman";
  cscale-radius = 3;

  # Deband
  deband = true;
  deband-iterations = 4;
  deband-threshold = 48;
  deband-range = 18;
  deband-grain = 32;

  # Audio
  volume = 100;
  volume-max = 200;
  audio-file-auto = "fuzzy";
  audio-pitch-correction = true;

  # Subtitles
  demuxer-mkv-subtitle-preroll = true;
  sub-ass-vsfilter-blur-compat = true;
  stretch-image-subs-to-screen = true;
  sub-fix-timing = true;
  sub-font = "Cabin";
  sub-font-size = 20;
  sub-border-size = 2;
  sub-auto = "fuzzy";
  sub-bold = true;
  sub-scale = 0.5;

  # Window
  osc = false;
  osd-bar = false;
  border = false;
  osd-font = "CaskaydiaCove Nerd Font Mono";
  title = "\${media-title} [\${time-pos}\${!duration==0: / \${duration}}]";
  force-window-position = true;
  autofit-larger = "100%x85%";
  cursor-autohide = 100;
  force-window = true;
  keep-open = true;

  # Track Selection
  slang = "en,eng";
  alang = "en,eng,ja,jp,jpn";

  # Screenshot
  screenshot-format = "png";
  screenshot-high-bit-depth = false;
  screenshot-tag-colorspace = true;
  screenshot-png-compression = 9;
  screenshot-directory = "~/Pictures/Screenshots";
  screenshot-template = "mpvshot-%03n %tHh%tMm%tSs";

  # Streaming
  hls-bitrate = "max";
  ytdl-format = "bestvideo[height<=?1440]+bestaudio/bestvideo+bestaudio/best";
  ytdl-raw-options = "ignore-errors=";
  load-unsafe-playlists = true;
}
