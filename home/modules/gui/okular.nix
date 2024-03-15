{ pkgs, ... }: {
  home.packages = with pkgs; [ okular ]

  xdg.desktopEntries = {
    discord = {
      name = "Okular";
      exec = "okular";
    };
  };
}
