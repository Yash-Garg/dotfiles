{
  fetchFromGitHub,
  stdenvNoCC,
  lib,
}:
stdenvNoCC.mkDerivation rec {
  name = "repl";

  src = fetchFromGitHub {
    owner = "rossy";
    repo = "mpv-repl";
    rev = "f7538adea92b441f2c7edd5dc07dd50dac28d3d5";
    hash = "sha256-e7BG21XQLjMHxZCIrvc6EKdT97YZiP+JQbJXksZyflo=";
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
