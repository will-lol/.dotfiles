{
  services.flatpak.packages = [{
    appId = "com.valvesoftware.Steam";
    origin = "flathub";
  }];
  services.flatpak.overrides = {
    "com.valvesoftware.Steam".Context = {
      filesystems = [ "/mnt/HDD/games/" ];
    };
  };
}
