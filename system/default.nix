let
  base = [
    ./core
    ./nix
    ./hardware
  ];

  laptop = base ++ [
    ./programs
    ./services
  ];
in
{
  inherit laptop base;
}
