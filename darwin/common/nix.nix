{ pkgs, config, ... }: {
	nix = {
		package = pkgs.nixVersions.latest;
		settings.trusted-users = [ "@admin" "${config.username}" ];
		extraOptions = ''
			experimental-features = nix-command flakes
		'';
	};

	services.nix-daemon.enable = true;

	system.checks.verifyNixPath = false;
}
