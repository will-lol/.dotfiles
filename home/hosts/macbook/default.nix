{
  pkgs,
  config,
  nix-colors,
  ...
}: {
  imports = [
    ../../../secrets.nix
    ../../modules/tui
    ../../modules/tui/darwin
    ./home.nix
  ];
}
