{
  description = "Flake for collie-hub";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
  };


  outputs = { self, nixpkgs }:

    let
      # These tools are pre-installed in github actions, so we can save the time for installing them.
      github_actions_preinstalled = pkgs:
        with pkgs;
        [
          nodejs
        ];

      # core packasges required in CI and not preinstalled in github actions
      core_packages = pkgs:
        with pkgs;
        [
          # terraform tools
          opentofu
          terragrunt
          tflint
          terraform-docs
        ];

      defaultShellForSystem = system:
        let
          pkgs = import nixpkgs { inherit system; config = { }; };
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
              system = "x86_64-linux";
              pkgs = import nixpkgs { inherit system; config = { }; };
            in
            pkgs.mkShell {
              name = "collie-hub-ghactions";
              packages = (core_packages pkgs);
            };
        };
      };
    };
}
