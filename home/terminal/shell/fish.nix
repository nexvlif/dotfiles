{ pkgs, ... }:
{
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
}
