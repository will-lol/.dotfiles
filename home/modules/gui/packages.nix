{pkgs, ...}: {
  home.packages = with pkgs; [
    mixxx
    gimp
    ydotool
    calibre
    obs-studio
    audacity
    xorg.xwininfo
    # zotero
    mpv
    lunar-client
  ];

  services.flatpak.enable = true;
  services.flatpak.update.onActivation = true;
  services.flatpak.uninstallUnmanagedPackages = true;
}
