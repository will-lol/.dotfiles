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
    homeManagerModules = [
      nixvim.homeManagerModules.nixvim
      nur.nixosModules.nur
      nix-colors.homeManagerModules.default
      xremap-flake.homeManagerModules.default
    ];
    nixosModules = [ sops-nix.nixosModules.sops ];
    localpkgs = import ./localPackages pkgs; 
  in {
    devShell.x86_64-linux = pkgs.mkShell {
      packages = [ (import ./apply-script.nix { inherit pkgs; }) ];
    };
    nixosConfigurations = {
      desktop = lib.nixosSystem {
        inherit system;
	modules = [
          ./nixos/desktop
	  home-manager.nixosModules.home-manager
	  {
	    home-manager = {
	      useGlobalPkgs = true;
	      useUserPackages = true;
	      users.will.imports = [
		./home/hosts/desktop	
	      ] ++ homeManagerModules;
	      extraSpecialArgs = { inherit nix-colors; inherit localpkgs; inherit xremap-flake; };
	    };
	  }
	] ++ nixosModules;
      };
    };
  };
}
