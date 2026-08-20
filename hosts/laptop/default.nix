{ inputs, ... }:
{
  imports = [
    ./configuration.nix
    inputs.hm.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.nex = import ../../home;
    }
  ];
}
