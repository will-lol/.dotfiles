{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    monitor = ["DP-1,1920x1080@75,0x0,1"];
  };
}
