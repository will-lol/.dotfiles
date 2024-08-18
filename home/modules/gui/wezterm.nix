{config}: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    colorSchemes = {
        foreground = "${config.colorScheme.palette.base08}";
        background = "${config.colorScheme.palette.base00}";

        cursor_bg = "${config.colorScheme.palette.base08}";
        cursor_border = "${config.colorScheme.palette.base08}";
        cursor_fg = "${config.colorScheme.palette.base00}";
        selection_bg = "${config.colorScheme.palette.base0D}";
        selection_fg = "${config.colorScheme.palette.base08}";
        split = "${config.colorScheme.palette.base04}";
        compose_cursor = "${config.colorScheme.palette.base0F}";
        scrollbar_thumb = ${config.colorScheme.palette.base02};

        regular0 = "${config.colorScheme.palette.base00}";
        regular1 = "${config.colorScheme.palette.base08}";
        regular2 = "${config.colorScheme.palette.base0B}";
        regular3 = "${config.colorScheme.palette.base0A}";
        regular4 = "${config.colorScheme.palette.base0D}";
        regular5 = "${config.colorScheme.palette.base0E}";
        regular6 = "${config.colorScheme.palette.base0C}";
        regular7 = "${config.colorScheme.palette.base09}";
        bright0 = "${config.colorScheme.palette.base03}";
        bright1 = "${config.colorScheme.palette.base08}";
        bright2 = "${config.colorScheme.palette.base0B}";
        bright3 = "${config.colorScheme.palette.base0A}";
        bright4 = "${config.colorScheme.palette.base0D}";
        bright5 = "${config.colorScheme.palette.base0E}";
        bright6 = "${config.colorScheme.palette.base0C}";
        bright7 = "${config.colorScheme.palette.base07}";
        "16" = "${config.colorScheme.palette.base05}";
        "17" = "${config.colorScheme.palette.base0F}";
        "18" = "${config.colorScheme.palette.base01}";
        "19" = "${config.colorScheme.palette.base05}";
        "20" = "${config.colorScheme.palette.base04}";
        "21" = "${config.colorScheme.palette.base06}";
    };
    
  
}
