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
    ./display.nix
  ];
}
