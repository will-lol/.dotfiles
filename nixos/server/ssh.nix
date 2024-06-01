{config, ...}: {
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  users.users.${config.username}.openssh.authorizedKeys.keyFiles = [
    ${config.sops.secrets."sshkey/public".path}
  ];
  # enable non interactive sudo using ssh keys
  security.pam.services.sudo.sshAgentAuth = true;
}
