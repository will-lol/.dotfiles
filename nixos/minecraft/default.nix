{ pkgs, ... }: {
  imports = [
    ./bootloader.nix
    ./minecraft.nix
  ];

  system.stateVersion = "23.05";
}
