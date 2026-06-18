{ pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.starship.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      alias ls 'eza --icons --color=always --group-directories-first'
      alias ll 'eza -alF --icons --color=always --group-directories-first'
      alias la 'eza -a --icons --color=always --group-directories-first'
      alias l  'eza -F --icons --color=always --group-directories-first'
      alias l. 'eza -a | egrep "^\."'
      alias c  'clear'
    '';
  };
}
