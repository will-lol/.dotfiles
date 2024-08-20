{ config, ... }: {
  services.mako = {
    enable = true;
    borderColor = "#${config.colorScheme.palette.base04}";
    textColor = "#${config.colorScheme.palette.base05}";
    defaultTimeout = 3000;
    backgroundColor = "#${config.colorScheme.palette.base01}";
  };
}
