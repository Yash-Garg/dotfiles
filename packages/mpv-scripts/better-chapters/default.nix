{
  fetchurl,
  stdenvNoCC,
  lib,
}:
stdenvNoCC.mkDerivation rec {
  name = "betterchapters";
  dontUnpack = true;

  src = fetchurl {
    url = "https://gist.githubusercontent.com/Hakkin/4f978a5c87c31f7fe3ae/raw/1d1daf22f0ec5f0219e4e72216e772828f5c8e4c/betterchapters.lua";
    hash = "sha256-bPH9sm/aO/FnWYY8K+2DFjFahaOCrSj5Es2bqfBk9ow=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/mpv/scripts
    cp ${src} $out/share/mpv/scripts/${name}.lua

    runHook postInstall
  '';

  passthru.scriptName = "${name}.lua";

  meta = with lib; {
    homepage = "https://gist.github.com/Hakkin/4f978a5c87c31f7fe3ae";
    platforms = platforms.all;
  };
}
