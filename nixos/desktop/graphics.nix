{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    libva-utils # For vaapi
    nvtop-nvidia
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [vaapiVdpau libvdpau-va-gl nvidia-vaapi-driver];
  };

  services.xserver.videoDrivers = ["nvidia"]; # Load nvidia driver for Xorg AND Wayland

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
