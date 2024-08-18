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
    ../../modules/gui/linux
    ./home.nix
    ./display.nix
  ];
}
