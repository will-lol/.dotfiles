{ pkgs, config, nix-colors, ... }: {
  imports = [
    ../../modules/tui
    ../../modules/wm
    ../../modules/gui
    ./xremap.nix
    ./home.nix
    ./display.nix
  ];
}