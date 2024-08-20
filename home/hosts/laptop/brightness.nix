{ pkgs, config, ... }: {
  home.file = {
    ".config/wob/brightness.ini".text = ''
      anchor = bottom
      margin = 100
      border_size = 2
      bar_padding = 2
      border_offset = 2
      background_color = ${config.colorScheme.palette.base01}
      border_color = ${config.colorScheme.palette.base06}
      bar_color = ${config.colorScheme.palette.base0B}
      height = 30
    '';
  };
  wayland.windowManager.hyprland.settings = {
    env = [ "WOBSOCK_BRIGHTNESS,$XDG_RUNTIME_DIR/brightness.sock" ];
    exec-once = [
      "rm -f $WOBSOCK_BRIGHTNESS && mkfifo $WOBSOCK_BRIGHTNESS && tail -f $WOBSOCK_BRIGHTNESS | ${pkgs.wob}/bin/wob -c ~/.config/wob/brightness.ini"
    ];
    binde = [
      ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 2%- && ${pkgs.kalker}/bin/kalker trunc\\($(${pkgs.brightnessctl}/bin/brightnessctl g)/$(${pkgs.brightnessctl}/bin/brightnessctl m)*100\\) > $WOBSOCK_BRIGHTNESS"
      ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 2%+ && ${pkgs.kalker}/bin/kalker trunc\\($(${pkgs.brightnessctl}/bin/brightnessctl g)/$(${pkgs.brightnessctl}/bin/brightnessctl m)*100\\) > $WOBSOCK_BRIGHTNESS"
    ];
  };
}
