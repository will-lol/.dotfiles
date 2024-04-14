{
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  users.users.will.extraGroups = ["networkmanager"];
}
