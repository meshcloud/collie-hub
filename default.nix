{ pkgs ? import <nixpkgs-unstable> { } }:

pkgs.mkShell {
  NIX_SHELL = "landing-zone-construction-kit";

  buildInputs = [
    # build tools
    pkgs.just
    pkgs.deno

    # terraform and friends
    pkgs.terraform
    pkgs.terragrunt
    pkgs.tflint
    pkgs.terraform-docs

    # node / typescript for docs
    pkgs.nodejs-16_x
    (pkgs.yarn.override {
        nodejs = pkgs.nodejs-16_x;
    })
  ];
}
