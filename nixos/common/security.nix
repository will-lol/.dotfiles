{ pkgs, ... }: {
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };

  security = {
    polkit.enable = true; # Required by Wayland
    sudo = {
      extraRules = [
        {
          users = [ "will" ];
          commands = [
            {
              command = "${pkgs.ydotool}/bin/";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
  };

  users.users.will.extraGroups = [ "wheel" ]; 
}
