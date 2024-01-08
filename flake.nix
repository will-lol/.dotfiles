{
  description = "System Config";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    nur.url = "github:nix-community/NUR";
    nvim-config.url = "./users/will/nvim";
  };

  outputs = { nixpkgs, home-manager, nix-colors, nur, ... }:
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
    lib = nixpkgs.lib;
    localpkgs = import ./localPackages pkgs; 
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
	  nur.nixosModules.nur
	];
	extraSpecialArgs = { inherit nix-colors; inherit localpkgs; };
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
