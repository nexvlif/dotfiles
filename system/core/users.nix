{ pkgs, ... }:
{
  users.users.nex = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = with pkgs; [ tree ];
    shell = pkgs.fish;
  };
}
