{ pkgs, ... }: {
  home.packages = with pkgs; [
    sops
    ripgrep
    neo-cowsay
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
