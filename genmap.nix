{ lib, stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "genmap";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "cpockrandt";
    repo = "genmap";
    rev = "genmap-v${version}";
    fetchSubmodules = true;
    sha256 = "sha256-7sIKBRMNzyCrZ/c2nXkknb6a5YsXe6DRE2IFhp6AviY=";
  };

  nativeBuildInputs = [ cmake ];

  # disable tests & benchmarks as these attempt to fetch googletest
  # and googlebenchmark via git
  preConfigure = ''
    echo > tests/CMakeLists.txt
    echo > benchmarks/CMakeLists.txt
  '';

  meta = {
    description = "Ultra-fast computation of genome mappability";
    license = lib.licenses.bsd3;
    homepage = "https://github.com/cpockrandt/genmap";
    maintainers = with lib.maintainers; [ jbedo ];
    platforms = lib.platforms.unix;
  };
}