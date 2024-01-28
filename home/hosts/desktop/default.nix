{ pkgs, config, nix-colors, ... }: {
  imports = [
    ../../modules/tui
    ../../modules/wm
    ../../modules/gui
    ./home.nix
    ./display.nix
  ];
}
