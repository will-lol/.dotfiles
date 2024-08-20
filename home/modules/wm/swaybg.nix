{ pkgs, config, ... }: {
  home.packages = with pkgs; [ swaybg ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [ ''swaybg -c "##${config.colorScheme.palette.base00}"'' ];
  };
}
