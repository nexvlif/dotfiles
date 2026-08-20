{ inputs, ... }:
{
  flake.nixosConfiguration = {
    laptop = import ./laptop { inherit inputs; };
  };
}
