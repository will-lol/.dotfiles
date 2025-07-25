{ pkgs, config, ... }:
{
  nix = {
    enable = false;
    linux-builder.enable = false;
    linux-builder.package = pkgs.darwin.linux-builder-x86_64;
    package = pkgs.nixVersions.latest;
    nixPath = [ { nixpkgs = "flake:nixpkgs"; } ];
    settings.trusted-users = [
      "@admin"
      "${config.username}"
    ];
    settings.experimental-features = "nix-command flakes";
    settings.extra-nix-path = "nixpkgs=flake:nixpkgs";
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  system.stateVersion = 5;
}
