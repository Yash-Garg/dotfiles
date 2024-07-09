{
  fetchurl,
  stdenvNoCC,
  lib,
}:
stdenvNoCC.mkDerivation rec {
  name = "status-line";
  dontUnpack = true;

  src = fetchurl {
    url = "https://raw.githubusercontent.com/mpv-player/mpv/daa6068d02fd8a68a5f7d23c0f8f1b4166f75fbe/TOOLS/lua/status-line.lua";
    hash = "sha256-xSndfsboaHzSS1KfO3ZM+q6TYZ1GMUVonQVlmNCbw1Q=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/mpv/scripts
    cp ${src} $out/share/mpv/scripts/${name}.lua

    runHook postInstall
  '';

  passthru.scriptName = "${name}.lua";

  meta = with lib; {
    homepage = "https://github.com/mpv-player/mpv/tree/master/TOOLS/lua";
    platforms = platforms.all;
  };
}
