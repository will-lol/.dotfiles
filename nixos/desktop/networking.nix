{ pkgs, ... }: {
  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;
  users.users.will.extraGroups = [ "networkmanager" ];
}
