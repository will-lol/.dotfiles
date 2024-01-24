{ pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./networking.nix
    ./packages.nix
    ./graphics.nix
    ../common
  ];

  system.stateVersion = "23.11";
}
