{pkgs, ...}: {
  home.packages = with pkgs; [playerctl];

  wayland.windowManager.hyprland.settings = {
    exec-once = ["playerctld daemon"];
    bind = [
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"
    ];
  };
}
