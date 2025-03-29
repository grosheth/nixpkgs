{ lib, stdenv, fetchFromGitHub, go }:

stdenv.mkDerivation rec {
  pname = "gysmo";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "grosheth";
    repo = "gysmo";
    rev = "v${version}";
    sha256 = "uXyz7+9MXuH+JROpx07+zynnVrZNZfYk4XpTsHmqMgg=";
  };

  buildInputs = [ go ];

  buildPhase = ''
    export GOCACHE=$TMPDIR/go-build
    export HOME=$TMPDIR/home
    go build -mod=vendor -o gysmo src/main.go
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp gysmo $out/bin/
  '';

  meta = with lib; {
    description = "A tool to display system information with a focus on customization and aesthetics";
    homepage = "https://github.com/grosheth/gysmo";
    license = licenses.mit;
    maintainers = with maintainers; [ grosheth ];
  };
}
