{
  stdenvNoCC,
  lib,
}:
stdenvNoCC.mkDerivation {
  pname = "monolisa-nerdfonts";
  version = "2.015";
  src = ./.;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/
    if [ -d "$src/fonts" ]; then
      cp -r $src/fonts/*.ttf $out/share/fonts/truetype/
    else
      echo "No fonts found in $src/fonts"
      exit 0
    fi
  '';

  meta = with lib; {
    description = "Monolisa Nerd Fonts";
    homepage = "https://www.monolisa.dev/";
    platforms = platforms.all;
  };
}
