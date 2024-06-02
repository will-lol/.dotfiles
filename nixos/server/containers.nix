{pkgs, config, ...}: {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443];
  };
  virtualisation.oci-containers.containers = {
    dufs = {
      ports = ["80:5000"];
      volumes = [
        "/mnt/store:/data"
      ];
      image = "dufs";
      autoStart = true;
      imageFile = pkgs.dockerTools.buildLayeredImage {
        name = "dufs";
        tag = "latest";
        config = {
          Cmd = ["${pkgs.dufs}/bin/dufs" "-A"];
          WorkingDir = "/data";
          ExposedPorts = {
            "5000/tcp" = {};
          };
          Env = {
            "DUFS_AUTH" = "admin:$(cat ${config.sops.secrets."dufs/hash".path})@/:rw";
          };
        };
      };
    };
  };
}
