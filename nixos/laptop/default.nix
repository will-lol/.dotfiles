{ pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./networking.nix
    ./packages.nix
    ./graphics.nix
    ./fingerprint.nix
    ../common
    ../pc
  ];

  options.username = with pkgs.lib;
    mkOption {
      type = types.str;
      default = "will";
      description = "The username of the default/main admin user";
    };

  config = { system.stateVersion = "23.11"; };
}
