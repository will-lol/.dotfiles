{ config, ... }: {
  hardware.sane.enable = true;
  services.printing.enable = true;
  users.users.${config.username}.extraGroups = [ "scanner" "lp" ];
}
