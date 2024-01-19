{ pkgs, ... }: {
  imports = [
    ./automount-share.nix
    ./bluetooth.nix
    ./graphics.nix
    ./hardware.nix
    ./networking.nix
  ];

  system.stateVersion = "23.05";
}
