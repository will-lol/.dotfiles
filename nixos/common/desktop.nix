{
  services.flatpak.enable = true;

  fonts.fontDir.enable = true; # Enabled for greater compatability
  
  programs.hyprland.enable = true;

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [ "gtk" ];
      };
    };
  };
}
