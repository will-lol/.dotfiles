{
  hardware.sane.enable = true;
  services.printing.enable = true;
  users.users.will.extraGroups = [ "scanner" "lp" ];
}
