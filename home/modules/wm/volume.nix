{ pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    env = [ "WOBSOCK_VOLUME,$XDG_RUNTIME_DIR/volume.sock" ];
    exec-once = [ "rm -f $WOBSOCK_VOLUME && mkfifo $WOBSOCK_VOLUME && tail -f $WOBSOCK_VOLUME | wob" ];
    binde = [
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2/1.5*100)}' > $WOBSOCK_VOLUME"
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+ && wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2/1.5*100)}' > $WOBSOCK_VOLUME"
    ];
    bind = [
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2/1.5*100)}' > $WOBSOCK_VOLUME"
    ];
  };
}
