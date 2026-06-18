{
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
      pci = true;
      splash = false;
    };
  };

  services.hyprpolkitagent.enable = true;
}
