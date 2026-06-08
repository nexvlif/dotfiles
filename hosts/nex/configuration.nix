{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nuripaper.nixosModules.default
  ];

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "pnpacpi=off" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nexvlif";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jakarta";

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.printing.enable = true;
  services.nuripaper = {
    enable = true;
    image = "/home/nex/Pictures/nx.jpg";
  };
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.libinput.enable = true;

  users.users.nex = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = with pkgs; [ tree ];
    shell = pkgs.fish;
  };

  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.fish.enable = true;
  programs.steam.enable = true;
  programs.gamemode.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  environment.systemPackages = with pkgs; [
    kitty
    vim
    git
    pamixer
    brightnessctl
    dunst
    wget
    curl
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    dejavu_fonts
    nerd-fonts.fira-code

  ];

  system.stateVersion = "26.05";
}
