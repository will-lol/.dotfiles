{ pkgs, ... }: {
  home.packages = with pkgs; [
    mixxx
    discord-screenaudio
    gimp
    steam
    ydotool
    calibre
    obs-studio
    audacity
    xorg.xwininfo
    # zotero
    mpv
    lunar-client
  ];
}
