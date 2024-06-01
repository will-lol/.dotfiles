{config, ...}: {
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  systemd.services."sshpublickey" = {
    wantedBy = ["multi-user.target"];
    script = ''
      mkdir -p /etc/ssh/authorized_keys.d/${config.username}
      cat ${config.sops.secrets."sshkey/public".path} > /etc/ssh/authorized_keys.d/${config.username}
    '';
  };
}
