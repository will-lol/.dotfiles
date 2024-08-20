{ pkgs, config, ... }: {
  home.packages = with pkgs; [ wob ];

  home.file = {
    ".config/wob/wob.ini".text = ''
      anchor = bottom
      margin = 100
      border_size = 2
      bar_padding = 2
      border_offset = 2
      background_color = ${config.colorScheme.palette.base01}
      border_color = ${config.colorScheme.palette.base06}
      bar_color = ${config.colorScheme.palette.base0E}
      height = 30
    '';
  };

  wayland.windowManager.hyprland.settings = {
    env = [ "WOBSOCK_VOLUME,$XDG_RUNTIME_DIR/volume.sock" ];
    exec-once = [
      "rm -f $WOBSOCK_VOLUME && mkfifo $WOBSOCK_VOLUME && tail -f $WOBSOCK_VOLUME | wob"
    ];
    binde = [
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2/1.5*100)}' > $WOBSOCK_VOLUME"
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+ && wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2/1.5*100)}' > $WOBSOCK_VOLUME"
    ];
    bind = [
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2/1.5*100)}' > $WOBSOCK_VOLUME"
    ];
  };
}
