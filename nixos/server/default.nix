{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./networking.nix
    ../common
  ];

  options.username = with pkgs.lib; mkOption {
    type = types.str;
    default = "admin";
    description = "The username of the default/main admin user";
  };

  config = {
    system.stateVersion = "23.05";
  };
}
