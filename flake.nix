{
  description = "Monaspace fonts packaged as a nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    fu.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, fu }:
    fu.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        monaspace = pkgs.stdenvNoCC.mkDerivation {
          pname = "monaspace";
          version = "1.000";

          dontConfigure = true;

          src = pkgs.lib.cleanSource ./fonts/variable;

          installPhase = ''
            mkdir -p $out/share/fonts/truetype/
            cp $src/* $out/share/fonts/truetype/
          '';

          meta = { description = "The monaspace fonts collection"; };
        };

      in
      with pkgs;
      {
        formatter = nixpkgs-fmt;
        packages.default = monaspace;
      }
    );
}
