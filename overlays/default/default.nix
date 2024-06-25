{inputs, ...}: _final: prev: {
  # Set default fonts
  nerdfonts = prev.nerdfonts.override {
    fonts = ["CascadiaCode" "GeistMono" "JetBrainsMono"];
  };
}
