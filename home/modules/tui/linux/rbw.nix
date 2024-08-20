{ pkgs, config, ... }: {
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
      After = [ "sops-nix.service" ];
    };
    Install = { WantedBy = [ "default.target" ]; };
    Service = {
      ExecStart = pkgs.writeShellScript "rbw-login" ''
        export CLIENT_ID=$(< ${config.sops.secrets."bitwarden/client_id".path})
        export CLIENT_SECRET=$(< ${
          config.sops.secrets."bitwarden/client_secret".path
        })

        ${pkgs.expect}/bin/expect -c "spawn rbw register
        expect \"API key client__id: \"
        send \"$::env(CLIENT_ID)\\n\"
        expect \"API key client__secret: \"
        send \"$::env(CLIENT_SECRET)\\n\""

        unset CLIENT_ID
        unset CLIENT_SECRET
      '';
    };

  };
}
