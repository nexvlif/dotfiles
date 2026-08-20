{ inputs, ... }:
{
  flake.nixosConfigurations = {
    laptop = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./laptop
      ];
    };
  };
}
