{ ... }:
{
  imports = [
    ./programs
    ./services
  ];

  home.username = "nex";
  home.homeDirectory = "/home/nex";
  home.stateVersion = "26.05";
}
