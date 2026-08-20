{ config, pkgs, ... }:

{
  home.username = "nex";
  home.homeDirectory = "/home/nex";

  home.packages = with pkgs; [
    google-chrome
    spotify
    steam
    discord
    rofi
    opencode

    zip
    unzip

    btop

    fastfetch
    cava
  ];

  services.dunst.enable = true;

  programs.git = {
    enable = true;
    userName = "Nex";
    userEmail = "nexvlif@gmail.com";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zoxide = {
    enable = true;
  };

  home.stateVersion = "26.05";
}
