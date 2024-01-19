{ pkgs, ... }: {
  home.packages = with pkgs; [
    parallel
    sops
    ripgrep
    trashy
    aria2
    entr
    htop-vim
    yt-dlp
    gcc
    kalker
    ffmpeg
    unzip
  ];
}
