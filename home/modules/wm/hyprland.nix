{ pkgs, config, ... }: {
  home.packages = with pkgs; [ grim slurp cliphist wl-clipboard hyprpicker swaybg swayimg playerctl ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      misc {
        disable_hyprland_logo = true
      }

      animations {
        enabled = no
      }

      bind = SUPER, Return, exec, alacritty

      monitor = DP-1,1920x1080@75,0x0,1
      
      env = WLR_NO_HARDWARE_CURSORS,1
      exec-once = hyprctl setcursor macOS-Monterey 24
      
      exec-once = waybar

      exec-once = swaybg -c "##${config.colorScheme.colors.base00}"
      general {
        col.active_border = rgb(${config.colorScheme.colors.base05})
	col.inactive_border = rgb(${config.colorScheme.colors.base04})
      }
      
      exec-once = playerctld daemon
      bind =, XF86AudioPlay, exec, playerctl play-pause
      bind =, XF86AudioPrev, exec, playerctl previous
      bind =, XF86AudioNext, exec, playerctl next

      exec-once = sudo -b ${pkgs.ydotool}/bin/ydotoold --socket-path="$HOME/.ydotool_socket" --socket-own="$(id -u):$(id -g)"
      env = YDOTOOL_SOCKET,$HOME/.ydotool_socket

      env = WOBSOCK,$XDG_RUNTIME_DIR/wob.sock
      exec-once = rm -f $WOBSOCK && mkfifo $WOBSOCK && tail -f $WOBSOCK | wob
      binde =,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2/1.5*100)}' > $WOBSOCK
      binde =,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+ && wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2/1.5*100)}' > $WOBSOCK
      bind =,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2/1.5*100)}' > $WOBSOCK

      bind =, Print, exec, grim -g "$(slurp)" - | wl-copy -t image/png
      bind = SUPER, Print, exec, NAME=$(uuidgen).png;grim -g "$(slurp)" /tmp/$NAME.png; gimp /tmp/$NAME.png

      bind = SUPER, H, movefocus, l
      bind = SUPER, L, movefocus, r
      bind = SUPER, K, movefocus, u
      bind = SUPER, J, movefocus, d

      bind = SUPER SHIFT, Q, killactive
     
      bind = SUPER, H, movewindow, l
      bind = SUPER, L, movewindow, r
      bind = SUPER, K, movewindow, u
      bind = SUPER, J, movewindow, d

      bind = SUPER, R, submap, resize
      submap = resize
      binde =, L, resizeactive, 40 0
      binde =, H, resizeactive, -40 0
      binde =, K, resizeactive, 0 -40
      binde =, J, resizeactive, 0 40
      bind =, escape, submap, reset
      bind =, Return, submap, reset
      submap = reset

      bind = SUPER, 1, workspace, 1
      bind = SUPER, 2, workspace, 2
      bind = SUPER, 3, workspace, 3
      bind = SUPER, 4, workspace, 4
      bind = SUPER, 5, workspace, 5
      bind = SUPER, 6, workspace, 6
      bind = SUPER, 7, workspace, 7
      bind = SUPER, 8, workspace, 8
      bind = SUPER, 9, workspace, 9
      bind = SUPER, 0, workspace, 10

      bind = SUPER SHIFT, 1, movetoworkspacesilent, 1
      bind = SUPER SHIFT, 2, movetoworkspacesilent, 2
      bind = SUPER SHIFT, 3, movetoworkspacesilent, 3
      bind = SUPER SHIFT, 4, movetoworkspacesilent, 4
      bind = SUPER SHIFT, 5, movetoworkspacesilent, 5
      bind = SUPER SHIFT, 6, movetoworkspacesilent, 6
      bind = SUPER SHIFT, 7, movetoworkspacesilent, 7
      bind = SUPER SHIFT, 8, movetoworkspacesilent, 8
      bind = SUPER SHIFT, 9, movetoworkspacesilent, 9
      bind = SUPER SHIFT, 0, movetoworkspacesilent, 10

      bind = SUPER, mouse_down, workspace, e+1
      bind = SUPER, mouse_up, workspace, e-1

      bind = SUPER, D, exec, tofi-run | xargs hyprctl dispatch exec -- 

      input {
        repeat_delay = 250
	repeat_rate = 35
      }
    '';
  };

}
