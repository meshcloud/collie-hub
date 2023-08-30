{ pkgs ? import <nixpkgs-unstable> { } }:

pkgs.mkShell {
  NIX_SHELL = "collie hub";

  buildInputs = [
    # build tools
    pkgs.deno
    pkgs.pre-commit

    # terraform and friends
    pkgs.terraform
    pkgs.terragrunt
    pkgs.tflint
    pkgs.terraform-docs

    # node / typescript for docs
    pkgs.nodejs
  ];
}
