{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "pnpacpi=off" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nexvlif";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jakarta";

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.libinput.enable = true;

  users.users.nex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [ tree ];
    shell = pkgs.fish;
  };

  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    kitty vim neovim git pamixer
    brightnessctl dunst wget curl
  ];

  system.stateVersion = "26.05";
}
