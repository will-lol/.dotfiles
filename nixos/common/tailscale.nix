{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [ tailscale ];
  services.tailscale.enable = true;
  systemd.services.tailscale-autoconnect = {
    description = "Connect to Tailscale";

    after = [ "network-pre.target" "tailscale.service" ];
    wants = [ "network-pre.target" "tailscale.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig.Type = "oneshot";

    script = with pkgs; ''
      sleep 2
      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ "$status" = "Running" ]; then
        exit 0
      fi

      ${tailscale}/bin/tailscale up --authkey $(cat ${
        config.sops.secrets."tailscale".path
      })
    '';
  };
}
