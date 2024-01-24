{ pkgs, ... }: {
  home.pointerCursor = {
    package = pkgs.apple-cursor;
    name = "macOS-Monterey";
    gtk.enable = true;
    x11.enable = true;
  };
  wayland.windowManager.hyprland.settings = {
    env = ["WLR_NO_HARDWARE_CURSORS,1"];
    exec-once = ["hyprctl setcursor macOS-Monterey 24"];
  };
}
