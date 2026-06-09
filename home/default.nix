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

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "$HOME/Pictures/nx.png"
      ];
      wallpaper = [
        {
          monitor = "";
          path = "$HOME/Pictures/nx.png";
        }
      ];
    };
  };

  services.hyprpolkitagent.enable = true;

  programs.home-manager.enable = true;
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      window_padding_width = 4;
      cursor_trail = 3;
      cursor_shape = "beam";
    };
  };

  home.packages = with pkgs; [
    google-chrome
    spotify
    antigravity
    rofi
    obsidian
    opencode
    protonup-ng

    hyprpicker
    hyprshot

    nodejs

    direnv
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Ice";
  };
}
