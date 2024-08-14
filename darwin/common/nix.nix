{ pkgs, config, ... }: {
	nix = {
		package = pkgs.nixFlakes;
		settings.trusted-users = [ "@admin" "${config.username}" ];
		extraOptions = ''
			experimental-features = nix-command flakes
		'';
	};

	services.nix-daemon.enable = true;

	system.checks.verifyNixPath = false;
}
