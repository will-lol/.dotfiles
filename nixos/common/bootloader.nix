{
  boot.loader = {
    systemd-boot.enable = true; 
    efi.canTouchEfiVariables = true;
    grub.configurationLimit = 10; # Limits the number of nixos generations listed in grub
  };
}
