{ pkgs, config, ... }: {
  home.packages = with pkgs; [ wl-clipboard hyprpicker swaybg swayimg playerctl ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      misc.disable_hyprland_logo = true;
      animations.enabled = false;
      bind = [
        "SUPER, Return, exec, alacritty"

        "SUPER, H, movefocus, l"
        "SUPER, J, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, L, movefocus, d"

        "SUPER, H, movewindow, l"
        "SUPER, J, movewindow, r"
        "SUPER, K, movewindow, u"
        "SUPER, L, movewindow, d"

        "SUPER SHIFT, Q, killactive"

        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"
      ] ++ (builtins.concatLists (builtins.genList (x: ["SUPER, ${toString (x+1)}, workspace, ${toString (x+1)}"]) 9)) ++ (builtins.concatLists (builtins.genList (x: ["SUPER SHIFT, ${toString (x+1)}, movetoworkspacesilent, ${toString (x+1)}"]) 9));

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
