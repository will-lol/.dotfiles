{ config, ... }: {
  services.mako = {
    enable = true;
    borderColor = "#${config.colorScheme.colors.base04}";
    textColor = "#${config.colorScheme.colors.base05}";
    defaultTimeout = 3000;
    backgroundColor = "#${config.colorScheme.colors.base01}";
  };
}
