{
  hardware.uinput.enable = true; # Enables virtual input devices
  security.rtkit.enable = true; # Enables realtime permissions for non-root applications
  users.users.will.extraGroups = [ "input" "uinput" ];
}
