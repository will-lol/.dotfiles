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
    # zotero
    mpv
    lunar-client
  ];
}
