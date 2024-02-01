{ pkgs, ... }: {
  home.packages = with pkgs; [ vesktop ];
  xdg.desktopEntries = {
    discord = {
      name = "Discord";
      exec = "vesktop --enable-features=UseOzonePlatform --ozone-platform=wayland";
    };
  };
}
