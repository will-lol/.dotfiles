{ pkgs, config, ... }: {
  home.packages = with pkgs; [ wl-clipboard hyprpicker swaybg swayimg playerctl ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      animations.enabled = false;
      misc.disable_hyprland_logo = true;
      bind = [
        "SUPER, Return, exec, alacritty"

        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"

        "SUPER ALT, H, movewindow, l"
        "SUPER ALT, L, movewindow, r"
        "SUPER ALT, K, movewindow, u"
        "SUPER ALT, J, movewindow, d"

        "SUPER SHIFT, Q, killactive"

        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"
      ] ++ (builtins.concatLists (builtins.genList (x: ["SUPER, ${toString (x+1)}, workspace, ${toString (x+1)}"]) 9)) ++ (builtins.concatLists (builtins.genList (x: ["SUPER SHIFT, ${toString (x+1)}, movetoworkspacesilent, ${toString (x+1)}"]) 9));

      bindm = [ "SUPER, mouse:272, movewindow" ];

      general = {
        "col.inactive_border" = "rgb(${config.colorScheme.colors.base04})";
        "col.active_border" = "rgb(${config.colorScheme.colors.base05})";
        "gaps_out" = "10";
      };

      input = {
        repeat_delay = "250";
        repeat_rate = "35";
        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true;
          scroll_factor = "0.2";
        };
      };
    };

    extraConfig = ''
bind = SUPER, R, submap, resize
submap = resize
binde =, L, resizeactive, 40 0
binde =, H, resizeactive, -40 0
binde =, K, resizeactive, 0 -40
binde =, J, resizeactive, 0 40
bind =, escape, submap, reset
bind =, Return, submap, reset
submap = reset
    '';
  };
}
