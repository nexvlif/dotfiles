{ pkgs, ... }:
{
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

  programs.git = {
    enable = true;
    userName = "Nex";
    userEmail = "nexvlif@gmail.com";
  };
}
