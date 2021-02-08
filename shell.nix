{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/20.09.tar.gz") {} }:

with pkgs;
let iqtree2 = stdenv.mkDerivation rec {
      pname = "iqtree2";
      version = "2.1.2";

      src = fetchFromGitHub {
        owner = "iqtree";
        repo = pname;
        rev = "v${version}";
        sha256 = "1bfa0kkb6vfcpa0vvx5cv1qinq3dachpzxbs5wqvp79ksyypbhyj";
      };

      nativeBuildInputs = [ cmake ];

      cmakeFlags = [
        "-DIQTREE_FLAGS=omp"
      ];

      buildInputs = [ boost eigen zlib ];

      meta = with lib; {
        description = "Efficient and versatile phylogenomic software by maximum likelihood";
        license = licenses.gpl2;
        homepage = "http://www.iqtree.org/";
        maintainers = let dschrempf = import ./dschrempf.nix; in [ dschrempf ];
        platforms = platforms.all;
      };
    };
in
mkShell {
    buildInputs = [ iqtree2 ];
    shellHook = ''
      echo "Welcome to the MIC-Phy PoMo workshop."
      echo "The following version of IQ-TREE2 is available:"
      echo
      iqtree2 --version
    '';
}

