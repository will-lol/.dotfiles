{ config, ... }: {
  programs.foot = {
    enable = true;
    settings = {
      colors = {
	background = "${config.colorScheme.colors.base00}";
	foreground = "${config.colorScheme.colors.base05}";
      }; 
      main = {
	font = "FiraCode Nerd Font:size=12";
	dpi-aware = true;
      };
    };
  };
}
