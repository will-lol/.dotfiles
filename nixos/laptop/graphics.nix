{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ libva-utils intel-gpu-tools ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver ];
  };
}
