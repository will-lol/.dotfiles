{
  pkgs,
  config,
  nix-colors,
  ...
}: {
  imports = [
    ../../../secrets.nix
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
