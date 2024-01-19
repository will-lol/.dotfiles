{ pkgs, ... }: {
  home.pointerCursor = {
    package = pkgs.apple-cursor;
    name = "macOS-Monterey";
    gtk.enable = true;
    x11.enable = true;
  };
}
