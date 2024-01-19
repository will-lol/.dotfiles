{ pkgs, config, nix-colors, ... }: {
  imports = [
    ../../modules/tui
    ../../modules/wm
    ../../modules/gui
  ];

  nixpkgs.config.allowUnfree = true;
  home.username = "will";
  home.stateVersion = "23.05";
  colorScheme = nix-colors.colorSchemes.tokyo-night-storm;
  programs.home-manager.enable = true;
}
