{ pkgs, ... }: {
  imports = [
    ./bootloader.nix
    ./minecraft.nix
    ../common/nix.nix
  ];

  system.stateVersion = "23.05";
}
