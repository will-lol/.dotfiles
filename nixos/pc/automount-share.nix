{config, ...}: {
  systemd.services."automountcredentials" = {
    partOf = ["mnt-share.mount"];
    wantedBy = ["mnt-share.mount"];
    before = ["mnt-share.mount"];
    script = ''
      echo "username=will
      password=$(cat ${config.sops.secrets."samba".path})" > /etc/nixos/smb-secrets
    '';
  };

  fileSystems."/mnt/share" = {
    device = "//server.tailf4e2d.ts.net/will";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
  };
}
