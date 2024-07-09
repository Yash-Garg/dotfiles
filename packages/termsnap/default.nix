{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "termsnap";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "tomcur";
    repo = pname;
    rev = "${pname}-v${version}";
    sha256 = "sha256-D/cGJvTle+9uqu3yKZKk7p4sU3HjwqtJO6RwdUISjCs=";
  };

  cargoSha256 = "sha256-69BAGPaNrFGtg2t8YcpBXwGHJyA59Z6chlEaCJIQWk0=";

  meta = with lib; {
    description = "Create SVGs from terminal output";
    homepage = "https://github.com/tomcur/termsnap";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
