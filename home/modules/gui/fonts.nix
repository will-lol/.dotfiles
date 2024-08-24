{ pkgs, ... }: {
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    liberation_ttf
    libre-franklin
    libre-baskerville
    inter
    garamond-libre
    corefonts
  ];

}
