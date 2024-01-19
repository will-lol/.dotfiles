{ pkgs, ... }: {
  home.packages = with pkgs; [
    mixxx
    gimp
    steam
    ydotool
    calibre
    obs-studio
    audacity
    # zotero
    mpv
    lunar-client
  ];
}
