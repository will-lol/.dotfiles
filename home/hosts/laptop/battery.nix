{ pkgs, ... }: {
  programs.waybar = {
    settings = {
      mainBar = {
        modules-right = [ "battery" ]; 
      };
    };
  };
}
