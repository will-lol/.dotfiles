{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    wob
  ];

  home.file = {
    ".config/wob/wob.ini".text = ''
      anchor = bottom
      margin = 100
      border_size = 2
      bar_padding = 2
      border_offset = 2
      background_color = ${config.colorScheme.colors.base01}
      border_color = ${config.colorScheme.colors.base06}
      bar_color = ${config.colorScheme.colors.base0E}
      height = 30
    '';
  };
}
