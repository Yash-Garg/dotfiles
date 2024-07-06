_: _final: prev: {
  google-chrome = prev.google-chrome.overrideAttrs (prevAttrs: {
    postFixup = ''
      makeWrapper ${prev.lib.getExe prev.electron_27} $out/bin/${prevAttrs.pname} \
        --set "LOCAL_GIT_DIRECTORY" ${prev.git} \
        --add-flags $out/share/${prevAttrs.pname}/resources/app
    '';
  });

  nerdfonts = prev.nerdfonts.override {
    fonts = ["CascadiaCode" "GeistMono" "JetBrainsMono"];
  };

  slack = prev.slack.overrideAttrs (prevAttrs: {
    installPhase =
      prevAttrs.installPhase
      + ''
        rm $out/bin/slack

        makeWrapper $out/lib/slack/slack $out/bin/slack \
          --add-flags "--enable-features=WebRTCPipeWireCapturer" \
          --add-flags "--enable-features=WaylandWindowDecorations" \
          --add-flags "--ozone-platform-hint=auto"
      '';
  });

  vesktop = prev.vesktop.override {withSystemVencord = false;};
}
