{pkgs, ...}: {
  home.packages = with pkgs; [grim slurp];
  wayland.windowManager.hyprland.settings = {
    bind = [
      ", Print, exec, grim -g \"$(slurp)\" - | wl-copy -t image/png"
      "SUPER, Print, exec, NAME=$(uuidgen).png;grim -g \"$(slurp)\" /tmp/$NAME.png; gimp /tmp/$NAME.png"
    ];
  };
}
