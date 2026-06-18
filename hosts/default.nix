{ self, inputs, ... }:
let
  system = import ../system;
in
{
  flake.nixosConfigurations = {
    nex = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs self; };
      modules = system.laptop ++ [
        ./nex/configuration.nix

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
