{config, ...}: {
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  users.users.${config.username}.extraGroups = ["networkmanager"];
}
