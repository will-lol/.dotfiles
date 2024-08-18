{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode"];})
    liberation_ttf
    libre-franklin
    libre-baskerville
    inter
    garamond-libre
    corefonts
  ];

  home.file = {
    ".config/fontconfig/fonts.conf".text = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
      <fontconfig>
        <match target="pattern">
          <test name="family" qual="any">
            <string>monospace</string>
          </test>
          <edit binding="strong" mode="prepend" name="family">
            <string>FiraCode Nerd Font</string>
          </edit>
        </match>
        <match target="pattern">
          <test name="family" qual="any">
            <string>sans-serif</string>
          </test>
          <edit binding="strong" mode="prepend" name="family">
            <string>Inter</string>
          </edit>
        </match>
        <match target="pattern">
          <test name="family" qual="any">
            <string>serif</string>
          </test>
          <edit binding="strong" mode="prepend" name="family">
            <string>Garamond Libre</string>
          </edit>
        </match>
      </fontconfig>
    '';
  };
}
