{
  networking.hostName = "desktop";
  networking.networkmanager.enable = true;
  users.users.virt.extraGroups = ["networkmanager"];
}
