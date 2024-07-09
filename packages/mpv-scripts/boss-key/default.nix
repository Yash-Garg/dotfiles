{
  fetchFromGitHub,
  stdenvNoCC,
  lib,
}:
stdenvNoCC.mkDerivation rec {
  name = "boss-key";

  src = fetchFromGitHub {
    owner = "detuur";
    repo = "mpv-scripts";
    rev = "0125d5eaaa6614464fbb0ee4fb7aa22a942367e8";
    hash = "sha256-b3Z9T1NfNdUzUF3to1DhBm6CpiXnoBDfaRqzXrIE8ds=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/mpv/scripts
    cp ${name}.lua $out/share/mpv/scripts

    runHook postInstall
  '';

  passthru.scriptName = "${name}.lua";

  meta = with lib; {
    license = licenses.mit;
    homepage = "https://github.com/detuur/mpv-scripts";
    platforms = platforms.all;
  };
}
