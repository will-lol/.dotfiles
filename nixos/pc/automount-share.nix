{config, ...}: {
  services.davfs2.enable = true;

  systemd.services."automountcredentials" = {
    partOf = ["mnt-store.mount"];
    wantedBy = ["mnt-store.mount"];
    before = ["mnt-store.mount"];
    script = ''
      echo "http://server.squeaker-eel.ts.net/ admin $(${config.sops.secrets."dufs/pw".path})" > /etc/davfs2/secrets 
    '';
  };

  fileSystems."/mnt/store" = {
    device = "http://server.squeaker-eel.ts.net/";
    fsType = "davfs";
    options = ["uid=1000,gid=100"];
  };
}
