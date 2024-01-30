{ pkgs, ... }: {
  imports = [
    ./bootloader.nix
    ./nix.nix
    ./sound.nix
    ./users.nix
    ./desktop.nix
    ./printer.nix
    ./secrets.nix
    ./hardware.nix
    ./packages.nix
    ./security.nix
    ./iossupport.nix
    ./virtualisation.nix
    ./minecraft.nix
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Australia/Hobart";
}
