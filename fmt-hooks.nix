{ inputs, ... }:
{
  imports = [
    inputs.git-hooks.flakeModule
    inputs.treefmt-nix.flakeModule
  ];

  perSystem = { config, pkgs, ... }: {
    pre-commit = {
      check.enable = true;
      settings = {
        excludes = [ "flake.lock" ];
	hooks.treefmt.enable = true;
      };
    };

    treefmt = {
      projectRootFile = "flake.nix";
      programs.nixpkgs-fmt.enable = true;
    };
  };
}
