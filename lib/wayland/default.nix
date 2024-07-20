{
  mkWaylandVariant =
    {
      lib,
      package,
      symlinkJoin,
      makeBinaryWrapper,
      WebRTCPipeWireCapturer ? true,
    }:
    let
      enableFeatures = lib.concatStringsSep "," (
        [
          "UseOzonePlatform"
          "WaylandWindowDecorations"
        ]
        ++ (lib.optional WebRTCPipeWireCapturer "WebRTCPipeWireCapturer")
      );
    in
    if lib.hasAttr "commandLineArgs" (lib.functionArgs package.override) then
      (package.override {
        commandLineArgs = [
          "--enable-features=${enableFeatures}"
          "--ozone-platform=wayland"
        ];
      })
    else
      let
        mainProgram =
          if lib.hasAttr "mainProgram" package.meta then package.meta.mainProgram else package.pname;
      in
      symlinkJoin {
        name = "${mainProgram}-wayland";
        paths = [ package ];
        buildInputs = [ makeBinaryWrapper ];
        postBuild = ''
          wrapProgram $out/bin/${mainProgram} \
            --add-flags "--enable-features=${enableFeatures}" \
            --add-flags "--ozone-platform=wayland"
        '';
      };
}
