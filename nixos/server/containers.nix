{pkgs, config, ...}: {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443];
  };
  systemd.services."podman-dufs-secrets" = {
    partOf = ["podman-dufs-secrets.service"];
    wantedBy = ["podman-dufs-secrets.service"];
    before = ["podman-dufs-secrets.service"];
    script = ''
      printf "admin:$(cat ${config.sops.secrets."dufs/hash".path})@/:rw|@/" | ${pkgs.podman}/bin/podman secret create dufs-auth -
    '';
  };
  systemd.services.podman-dufs = {
    requires = ["podman-dufs-secrets.service"];
    after = ["podman-dufs-secrets.service"];
  };
  virtualisation.oci-containers.containers = {
    dufs = {
      extraOptions = [
        "--secret=dufs-auth,type=env,target=DUFS_AUTH"
      ];
      ports = ["80:5000"];
      volumes = [
        "/mnt/store:/data"
      ];
      image = "dufs";
      autoStart = true;
      imageFile = pkgs.dockerTools.buildLayeredImage {
        name = "dufs";
        tag = "latest";
        fromImage = pkgs.dockerTools.pullImage {
          imageName = "debian";
          imageDigest = "sha256:fac2c0fd33e88dfd3bc88a872cfb78dcb167e74af6162d31724df69e482f886c";
          sha256 = "sha256-jVqcQ0kxwZYMQuq1ZSzzMzPVRvNhsvghmzmV5RwuTrQ=";
          finalImageTag = "bookworm";
          finalImageName = "debian";
        };
        config = {
          Cmd = ["${pkgs.dufs}/bin/dufs" "-A"];
          WorkingDir = "/data";
          ExposedPorts = {
            "5000/tcp" = {};
          };
        };
      };
    };
  };
}
