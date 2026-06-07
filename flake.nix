{
  description = "nxf";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lanzaboote.url = "github:nix-community/lanzaboote";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-compat.url = "github:edolstra/flake-compat";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [
        ./hosts
        ./fmt-hooks.nix
      ];

      perSystem =
        { pkgs, config, ... }:
        {
          devShells.default = pkgs.mkShell {
            packages = [ pkgs.git ];
            name = "dots";
            shellHook = ''
              ${config.pre-commit.installationScript}
            '';
          };
        };
    };
}
