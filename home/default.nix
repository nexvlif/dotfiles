{ pkgs, config, lib, ... }:

{
  home = {
    username = "nex";
    homeDirectory = "/home/nex";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    google-chrome
    spotify
    antigravity
    rofi
    opencode
  ];
}
