{pkgs, ...}: {
  imports = [
    ./automount-share.nix
    ./bluetooth.nix
    ./graphics.nix
    ./hardware.nix
    ./steam.nix
    ./networking.nix
    ../common
    ../pc
  ];

  system.stateVersion = "23.05";
}
