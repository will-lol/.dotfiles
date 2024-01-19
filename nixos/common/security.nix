{ pkgs, ... }: {
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses"; # Simple pin entry package
    enableSSHSupport = true;
  };
  environment.systemPackages = with pkgs; [ pinentry-curses ];

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
