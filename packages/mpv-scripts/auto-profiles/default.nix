{
  fetchFromGitHub,
  stdenvNoCC,
  lib,
}:
stdenvNoCC.mkDerivation rec {
  pname = "auto-profiles";
  version = "v1.4";

  src = fetchFromGitHub {
    owner = "Moodkiller";
    repo = "MPV-Made-Easy";
    rev = "57b0a488e6a7238b46f94a472368973f77e1054c";
    hash = "sha256-FSIrs/4QVNOg7tJFKRmnx0eRRDKlDahYn/ckntkwmCg=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/mpv/scripts
    cp scripts/${pname}.lua $out/share/mpv/scripts

    runHook postInstall
  '';

  passthru.scriptName = "${pname}.lua";

  meta = with lib; {
    license = licenses.gpl2;
    homepage = "https://github.com/Moodkiller/MPV-Made-Easy";
    platforms = platforms.all;
  };
}
