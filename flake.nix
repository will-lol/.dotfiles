{
  description = "System Config";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { nixpkgs, home-manager, hyprland, ... }:
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
    lib = nixpkgs.lib;
  in {
    homeManagerConfigurations = {
      will = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
	modules = [
          ./users/will/home.nix
	  {
	    home = {
              username = "will";
	      homeDirectory = "/home/will";
	    };
	  }
	  hyprland.homeManagerModules.default
	];
      };
    };

    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
	modules = [
          ./system/configuration.nix
	];
      };
    };
  };
}
