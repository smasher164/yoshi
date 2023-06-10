{
  description = "yoshi";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let supportedSystems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
    ]; in
    flake-utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [];
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            ocaml
            dune_3
            ocamlformat
            ocamlPackages.findlib
            ocamlPackages.utop
            ocamlPackages.odoc
            ocamlPackages.lsp
            ocamlPackages.ocaml-lsp
          ];
        };
      });
}
