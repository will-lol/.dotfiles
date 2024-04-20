{config, ...}: {
  networking.hostName = "server";
  networking.networkmanager.enable = true;
  users.users.${config.username}.extraGroups = ["networkmanager"];
}
