{ self, inputs, ... }:
{
  flake.nixosConfigurations = {
    nex = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs self; };
      modules = [
        ./nex/configuration.nix

        inputs.lanzaboote.nixosModules.lanzaboote

        inputs.hm.nixosModules.home-manager

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs self; };
            users.nex = {
              imports = [
                ../home
              ];
            };
          };
        }
      ];
    };
  };
}
