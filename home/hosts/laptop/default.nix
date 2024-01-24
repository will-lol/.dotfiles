{ pkgs, config, nix-colors, ... }: {
  imports = [
    ../../modules/tui
    ../../modules/wm
    ../../modules/gui
    ./home.nix
    ./battery.nix
    ./display.nix
    ./brightness.nix
  ];
}
