{ pkgs, ... }: {
  home.packages = with pkgs; [
    dig
    parallel
    sops
    ripgrep
    trashy
    aria2
    htop-vim
    yt-dlp
    gcc
    kalker
    ffmpeg
    unzip
    nethogs
  ];
}
