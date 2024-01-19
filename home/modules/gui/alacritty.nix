{ config, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = { 
	  background = "0x${config.colorScheme.colors.base00}";
	  foreground = "0x${config.colorScheme.colors.base05}";
	};  
	cursor = {
	  text = "0x${config.colorScheme.colors.base00}";
	  cursor = "0x${config.colorScheme.colors.base05}";
	};  
      };	  
    };
  };
}
