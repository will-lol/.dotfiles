{config, ...}: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    colorSchemes = {
      default = {
        foreground = "${config.colorScheme.palette.base08}";
        background = "${config.colorScheme.palette.base00}";

        cursor_bg = "${config.colorScheme.palette.base08}";
        cursor_border = "${config.colorScheme.palette.base08}";
        cursor_fg = "${config.colorScheme.palette.base00}";
        selection_bg = "${config.colorScheme.palette.base0D}";
        selection_fg = "${config.colorScheme.palette.base08}";
        split = "${config.colorScheme.palette.base04}";
        compose_cursor = "${config.colorScheme.palette.base0F}";
        scrollbar_thumb = "${config.colorScheme.palette.base02}";

        ansi = ["${config.colorScheme.palette.base00}" "${config.colorScheme.palette.base08}" "${config.colorScheme.palette.base0B}" "${config.colorScheme.palette.base0A}" "${config.colorScheme.palette.base0D}" "${config.colorScheme.palette.base0E}" "${config.colorScheme.palette.base0C}" "${config.colorScheme.palette.base09}"];
        
        brights = ["${config.colorScheme.palette.base03}" "${config.colorScheme.palette.base08}" "${config.colorScheme.palette.base0B}" "${config.colorScheme.palette.base0A}" "${config.colorScheme.palette.base0D}" "${config.colorScheme.palette.base0E}" "${config.colorScheme.palette.base0C}" "${config.colorScheme.palette.base07}"];
      };
    };
  };
}
