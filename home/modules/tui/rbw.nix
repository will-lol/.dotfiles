{pkgs, ...}: {
  programs.rbw = {
    enable = true;
    settings = {
      email = "will@ionata.com.au";
      pinentry = pkgs.pinentry-tty;
    };
  };

  systemd.user.services.rbw-auth = {
    Unit = {
      Description = "Authenticate with Bitwarden for rbw cli";
      After = ["sops-nix.service"];
    };
    Install = {
      WantedBy = ["default.target"];
    };
    Service = {
      ExecStart = pkgs.writeShellScript "rbw-login" ''
      '';
    };
    
  };
}
