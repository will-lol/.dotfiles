{config, ...}: {
	system.defaults = {
		screencapture.location = "/tmp";

		CustomUserPreferences = {
      "com.apple.finder".NewWindowTargetPath = "file:///Users/${config.username}/";
		};

    NSGlobalDomain.AppleICUForce24HourTime = true;
	};

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
