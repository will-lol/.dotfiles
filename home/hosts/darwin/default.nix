{
  pkgs,
  config,
  nix-colors,
  ...
}: {
  imports = [
    ../../modules/tui
    ../../modules/tui/darwin
    ./home.nix
  ];
}
