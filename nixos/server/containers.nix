{pkgs, ...}: {
  virtualisation.oci-containers.containers = {
    dufs = {
      ports = ["80:8080"];
      volumes = [
        "/mnt/store:/data"
      ];
      imageFile = pkgs.dockertools.buildLayeredImage {
        name = "dufs";
        config = {
          Cmd = ["${pkgs.dufs}" "-A" "-b" "127.0.0.1" "-p" "8080"];
          WorkingDir = "/data";
          Volumes = {
            "/data" = {};
          };
        };
      };
    };
  };
}
