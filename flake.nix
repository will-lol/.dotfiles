{
  description = "System Config";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    nur.url = "github:nix-community/NUR";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    xremap-flake.url = "github:xremap/nix-flake";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, nix-colors, nur, nixvim, xremap-flake, sops-nix, ... }:
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
	  nixvim.homeManagerModules.nixvim
          ./users/will/home.nix
	  {
	    home = {
              username = "will";
	      homeDirectory = "/home/will";
	    };
	  }
	  nur.nixosModules.nur
	];
	extraSpecialArgs = { inherit nix-colors; inherit localpkgs; inherit xremap-flake; };
      };
    };

    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
	modules = [
	  sops-nix.nixosModules.sops
          ./system/configuration.nix
	];
      };
    };
  };
}
