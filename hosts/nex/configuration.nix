{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nexvlif";

  environment.systemPackages = with pkgs; [
    kitty
    vim
    git
    pamixer
    brightnessctl
    dunst
    wget
    curl
    eza
  ];
}
