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
    prismlauncher
    mpv
    lunar-client
  ];
}
