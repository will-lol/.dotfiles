{
  pkgs,
  config,
  nix-colors,
  ...
}: {
  imports = [
    ../../modules/tui
    ../../modules/tui/linux
    ../../modules/wm
    ../../modules/gui
    ./home.nix
    ./display.nix
  ];
}
