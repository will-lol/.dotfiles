{ config, ... }: {
  networking.hostName = "desktop";
  networking.networkmanager.enable = true;
  users.users.${config.username}.extraGroups = [ "networkmanager" ];
}
