{
  networking.hostName = "desktop";
  networking.networkmanager.enable = true;
  users.users.will.extraGroups = ["networkmanager"];
}
