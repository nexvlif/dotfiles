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

    gcc
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Nex";
      user.email = "nexvlif@gmail.com";
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      cursor_trail = 3;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      notify_on_cmd_finish = "unfocused";
      window_padding_width = 4;
      confirm_os_window_close = 0;
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
    };
    shellIntegration.mode = "enabled";
    font = {
      name = "FiraCode Nerd Font";
      size = 11;
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --icons --color=always --group-directories-first";
      ll = "eza -alF --icons --color=always --group-directories-first";
      la = "eza -a --icons --color=always --group-directories-first";
      l = "eza -F --icons --color=always --group-directories-first";
      "l." = "eza -a | egrep '^\\.'";
      c = "clear";
    };
    interactiveShellInit = ''
      set -g fish_greeting ""
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zoxide = {
    enable = true;
  };
}
