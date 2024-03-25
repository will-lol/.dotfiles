{ pkgs, config, nix-colors, ... }: {
  imports = [
    ../../modules/tui
    ../../modules/tui/linux
    ../../modules/wm
    ../../modules/gui
    ./home.nix
    ./touchpad-gesture.nix
    ./battery.nix
    ./display.nix
    ./brightness.nix
  ];
}
