{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "termsnap";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "tomcur";
    repo = pname;
    rev = "${pname}-v${version}";
    sha256 = "sha256-FTgbbiDlHXGjkv3a2TAxjAqdClWkuteyUrtjQ8fMSIs=";
  };

  cargoSha256 = "sha256-hXlRkqcMHFEAnm883Q8sR8gcEbSNMutoJQsMW2M5wOY=";

  meta = with lib; {
    description = "Create SVGs from terminal output";
    homepage = "https://github.com/tomcur/termsnap";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
