{pkgs, ...}: {
  imports = [
    ./bluetooth.nix
    ./graphics.nix
    ./hardware.nix
    ./steam.nix
    ./networking.nix
    ../common
    ../pc
  ];

  options.username = with pkgs.lib; mkOption {
    type = types.str;
    default = "will";
    description = "The username of the default/main admin user";
  };

  config = {
    system.stateVersion = "23.05";
  };
}
