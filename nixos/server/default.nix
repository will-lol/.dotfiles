{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./networking.nix
    ../common
  ];

  system.stateVersion = "23.05";
}
