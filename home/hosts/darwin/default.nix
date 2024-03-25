{ pkgs, config, nix-colors, ... }: {
  imports = [
    ../../modules/tui
    ./home.nix
  ];
}
