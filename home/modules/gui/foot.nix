{ config, ... }: {
  programs.foot = {
    enable = true;
    settings = {
      colors = {
	background = "${config.colorScheme.colors.base00}";
	foreground = "${config.colorScheme.colors.base05}";
	regular0 = "${config.colorScheme.colors.base00}";
	regular1 = "${config.colorScheme.colors.base08}";
	regular2 = "${config.colorScheme.colors.base0B}";
	regular3 = "${config.colorScheme.colors.base0A}";
	regular4 = "${config.colorScheme.colors.base0D}";
	regular5 = "${config.colorScheme.colors.base0E}";
	regular6 = "${config.colorScheme.colors.base0C}";
	regular7 = "${config.colorScheme.colors.base09}";
	bright0 = "${config.colorScheme.colors.base03}";
	bright1 = "${config.colorScheme.colors.base08}";
	bright2 = "${config.colorScheme.colors.base0B}";
	bright3 = "${config.colorScheme.colors.base0A}";
	bright4 = "${config.colorScheme.colors.base0D}";
	bright5 = "${config.colorScheme.colors.base0E}";
	bright6 = "${config.colorScheme.colors.base0C}";
	bright7 = "${config.colorScheme.colors.base07}";
	"16" = "${config.colorScheme.colors.base05}";
	"17" = "${config.colorScheme.colors.base0F}";
	"18" = "${config.colorScheme.colors.base01}";
	"19" = "${config.colorScheme.colors.base05}";
	"20" = "${config.colorScheme.colors.base04}";
	"21" = "${config.colorScheme.colors.base06}";
      }; 

      main = {
	font = "FiraCode Nerd Font:size=12";
      };
    };
  };
}
