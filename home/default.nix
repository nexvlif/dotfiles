{ ... }:
{
  imports = [
    ./editors/nixvim
    ./programs
    ./services
    ./terminal
  ];

  home = {
    username = "nex";
    homeDirectory = "/home/nex";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
