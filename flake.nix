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

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    darwin,
    home-manager,
    nix-colors,
    nur,
    nixvim,
    xremap-flake,
    sops-nix,
    nix-flatpak,
    deploy-rs,
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
    homeSharedModules = [sops-nix.homeManagerModules.sops];
    nixosModules = [sops-nix.nixosModules.sops nix-flatpak.nixosModules.nix-flatpak];
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = [(import ./apply-script.nix {inherit pkgs;}) deploy-rs.defaultPackage.${system}];
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
            ({config, ...}: {
              home-manager = {
                useUserPackages = true;
                sharedModules = homeSharedModules;
                users.${config.username}.imports =
                  [
                    ./home/hosts/desktop
                    ({pkgs, ...}: {
                      options.username = with pkgs.lib; mkOption {
                        type = types.str;
                        default = config.username;
                        description = "The username of the user";
                      };
                    })
                  ]
                  ++ homeManagerModules;
                extraSpecialArgs = {
                  inherit nix-colors;
                  inherit xremap-flake;
                };
              };
            })
          ]
          ++ nixosModules;
      };
      server = lib.nixosSystem {
        inherit system;
        modules =
          [
            ./nixos/server
            # microvm.nixosModules.microvm
          ]
          ++ nixosModules;
      };
      laptop = lib.nixosSystem {
        inherit system;
        modules =
          [
            ./nixos/laptop
            home-manager.nixosModules.home-manager
            ({config, ...}: {
              home-manager = {
                useUserPackages = true;
                sharedModules = homeSharedModules;
                users.${config.username}.imports =
                  [
                    ./home/hosts/laptop
                    ({pkgs, ...}: {
                      options.username = with pkgs.lib; mkOption {
                        type = types.str;
                        default = config.username;
                        description = "The username of the user";
                      };
                    })
                  ]
                  ++ homeManagerModules;
                extraSpecialArgs = {
                  inherit nix-colors;
                  inherit xremap-flake;
                };
              };
            })
          ]
          ++ nixosModules;
      };
    };
    deploy.nodes.server = {
      hostname = "server.squeaker-eel.ts.net";
      fastConnection = true;
      profiles = {
        system = {
          sshUser = "admin";
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.server;
          user = "root";
        };
      };
    };
  };
}
