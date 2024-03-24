{ pkgs, ... }: {
  home.packages = with pkgs; [ okular ];

  # xdg.desktopEntries = {
  #   okular = {
  #     name = "Okular";
  #     exec = "okular";
  #   };
  # };
}
