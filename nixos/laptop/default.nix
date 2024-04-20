{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./networking.nix
    ./packages.nix
    ./graphics.nix
    ./fingerprint.nix
    ../common
    ../pc
  ];

  system.stateVersion = "23.11";
}
