{
  pkgs,
  config,
  lib,
  ...
}:

{

  imports = [
    ./editors/nixvim
  ];

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
    obsidian
    opencode
    protonup-ng

    nodejs

    direnv
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Ice";
  };
}
