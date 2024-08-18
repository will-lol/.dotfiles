{pkgs, config, ...}: {
	nix-homebrew = {
		enable = true;
		enableRosetta = true;
		user = config.username;
		mutableTaps = false;
	};

	homebrew = {
		enable = true;

		onActivation = {
			cleanup = "zap";
			upgrade = true;
			autoUpdate = true;
		};

		global = {
			brewfile = true;
			lockfiles = true;
		};
	};
}
