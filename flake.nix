{
  description = "Flake for collie-hub";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
  };


  outputs = { self, nixpkgs }:

  let
      # These tools are pre-installed in github actions, so we can save the time for installing them.
      # This can save as much as 20s (with nix on tmpfs), trading some consistency for perf.
      github_actions_preinstalled = pkgs:
        with pkgs;
        [
          awscli2
          (azure-cli.withExtensions [ azure-cli.extensions.account ])
          nodejs

          # note: google cloud sdk is not preinstalled in github actions
        ];

      # core packages required in CI and not preinstalled in github actions
      core_packages = pkgs:
        let
          # fake opentofu as terraform so that tools like terraform-docs pre-commit hook (which doesn't have tofu support)
          # fall back to tofu
          tofu_terraform =
            pkgs.stdenv.mkDerivation {
              name = "tofu-terraform";
              phases = [ "installPhase" ];
              installPhase = ''
                mkdir -p $out/bin
                echo '#!/usr/bin/env sh' > $out/bin/terraform
                echo 'tofu $@' > $out/bin/terraform
                chmod +x $out/bin/terraform
              '';
            };
        in
        with pkgs;
        [
          # terraform tools
          opentofu
          terragrunt
          tflint
          tfupdate
          terraform-docs

          # fake tofu as terraform
          tofu_terraform

          # script dependencies
          jq
          pre-commit
        ];

      importNixpkgs = system: import nixpkgs { inherit system; };

      defaultShellForSystem = system:
        let
          pkgs = importNixpkgs system;
        in
        {
          default = pkgs.mkShell {
            name = "collie-hub";
            packages = (github_actions_preinstalled pkgs) ++ (core_packages pkgs);
          };
        };

    in

    {
      devShells = {
        aarch64-darwin = (defaultShellForSystem "aarch64-darwin");
        x86_64-darwin = (defaultShellForSystem "x86_64-darwin");
        x86_64-linux = (defaultShellForSystem "x86_64-linux") // {
          # use a smaller/faster shell on github actions
          github_actions =
            let
              pkgs = importNixpkgs "x86_64-linux";
            in
                        pkgs.mkShell {
              name = "collie-hub-ghactions";
              packages = (core_packages pkgs);
            };
        };
      };
    };
}
