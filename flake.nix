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
    xremap-flake.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:LnL7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.3.0";

    microvm.url = "github:astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    darwin,
    home-manager,
    nix-colors,
    nur,
    nixvim,
    xremap-flake,
    sops-nix,
    nix-flatpak,
    microvm,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
    };
    inherit (nixpkgs) lib;
    homeManagerModules = [
      nixvim.homeManagerModules.nixvim
      nur.nixosModules.nur
      nix-colors.homeManagerModules.default
      xremap-flake.homeManagerModules.default
      nix-flatpak.homeManagerModules.nix-flatpak
    ];
    nixosModules = [sops-nix.nixosModules.sops nix-flatpak.nixosModules.nix-flatpak];
  in {
    devShell.x86_64-linux = pkgs.mkShell {
      packages = [(import ./apply-script.nix {inherit pkgs;})];
    };
    devShell.aarch64-linux = pkgs.mkShell {
      packages = [(import ./apply-script.nix {inherit pkgs;})];
    };
    darwinConfigurations = {
      Wills-MacBook-Pro = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./darwin
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              users.will.imports =
                [
                  ./home/hosts/darwin
                ]
                ++ homeManagerModules;
              extraSpecialArgs = {
                inherit nix-colors;
                inherit xremap-flake;
              };
            };
          }
        ];
      };
    };
    nixosConfigurations = {
      desktop = lib.nixosSystem {
        inherit system;
        modules =
          [
            ./nixos/desktop
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                users.will.imports =
                  [
                    ./home/hosts/desktop
                  ]
                  ++ homeManagerModules;
                extraSpecialArgs = {
                  inherit nix-colors;
                  inherit xremap-flake;
                };
              };
            }
          ]
          ++ nixosModules;
      };
      server = lib.nixosSystem {
        inherit system;
        modules =
          [
            ./nixos/server
            microvm.nixosModules.microvm
          ]
          ++ nixosModules;
      };
      laptop = lib.nixosSystem {
        inherit system;
        modules =
          [
            ./nixos/laptop
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                users.will.imports =
                  [
                    ./home/hosts/laptop
                  ]
                  ++ homeManagerModules;
                extraSpecialArgs = {
                  inherit nix-colors;
                  inherit xremap-flake;
                };
              };
            }
          ]
          ++ nixosModules;
      };
    };
  };
}
