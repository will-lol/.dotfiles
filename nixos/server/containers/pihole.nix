{ pkgs, config, ... }: {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 53 8080 ];
    allowedUDPPorts = [ 53 ];
  };
  systemd.services."podman-pihole-secrets" = {
    partOf = [ "podman-pihole-secrets.service" ];
    wantedBy = [ "podman-pihole-secrets.service" ];
    before = [ "podman-pihole-secrets.service" ];
    script = ''
      ${pkgs.podman}/bin/podman secret rm pihole-auth -i
      cat ${
        config.sops.secrets."pihole".path
      } | ${pkgs.podman}/bin/podman secret create pihole-auth -
    '';
  };
  systemd.services.podman-pihole = {
    requires = [ "podman-pihole-secrets.service" ];
    after = [ "podman-pihole-secrets.service" ];
  };
  virtualisation.oci-containers.containers = {
    pihole = {
      extraOptions = [ "--secret=pihole-auth,type=env,target=WEBPASSWORD" ];
      volumes = [ "pihole:/etc/pihole" "dnsmasq:/etc/dnsmasq.d" ];
      ports = [ "53:53/tcp" "53:53/udp" "8080:8080/tcp" ];
      environment = {
        TZ = "Australia/Hobart";
        WEB_PORT = "8080";
        DNSMASQ_LISTENING = "all";
        PIHOLE_DNS_ =
          "1.1.1.1;1.0.0.1;2606:4700:4700::1111;2606:4700:4700::1001";
        DNSSEC = "true";
        QUERY_LOGGING = "false";
      };
      image = "pihole/pihole";
      imageFile = pkgs.dockerTools.pullImage {
        imageName = "pihole/pihole";
        imageDigest =
          "sha256:8b1f31f46d94c3c1b8f509b302f28b4028483009bd27a9cbfd9b80185dd0687d";
        sha256 = "sha256-XqWZDZYvpRBPWZxR9X8gNeyVKqRpXPlVu+3rfdBOIvA=";
        finalImageTag = "latest";
        finalImageName = "pihole/pihole";
      };
      autoStart = true;
    };
  };
}
