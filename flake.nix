{
  description = "nx";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, hm, ... }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;

	modules = [
	  ./hosts/laptop/configuration.nix

	  hm.nixosModules.home-manager

	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.nex = import ./home;
	  }
	];
      };
    };
  };
}
