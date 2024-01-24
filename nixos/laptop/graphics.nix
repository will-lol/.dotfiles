{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    libva-utils
    intel-gpu-tools
  ];
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };
}
