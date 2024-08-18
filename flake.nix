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

    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.3.0";

    microvm.url = "github:astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... } @inputs:
      let
        supportedSystems = ["x86_64-linux" "aarch64-darwin"];

        lib = import ./lib.nix { inherit nixpkgs supportedSystems; };

        homeManagerModules = [
          inputs.nixvim.homeManagerModules.nixvim
          inputs.nur.nixosModules.nur
          inputs.nix-colors.homeManagerModules.default
        ];

        homeManagerModulesExtended = [
          inputs.xremap-flake.homeManagerModules.default
          inputs.nix-flatpak.homeManagerModules.nix-flatpak
        ] ++ homeManagerModules;
        homeSharedModules = [ inputs.sops-nix.homeManagerModules.sops ];

        nixosModules =
          [ inputs.sops-nix.nixosModules.sops inputs.nix-flatpak.nixosModules.nix-flatpak ];
      in {
        devShells = lib.forAllSupportedSystems (system: let pkgs = nixpkgs.legacyPackages.${system}; in {
          default = pkgs.mkShell {
            packages = [
              (pkgs.writeShellScriptBin "apply-nixos" ''
                set -euox pipefail
                pushd ~/.dotfiles
                rm -f ~/.mozilla/firefox/default/search.json.mozlz4
                sudo nixos-rebuild switch --upgrade --flake .#$1
                popd
              '')

              (pkgs.writeShellScriptBin "apply-darwin" ''
                set -euox pipefail
                pushd ~/.dotfiles
                darwin-rebuild switch --flake ".#$1"
                popd
              '')

              inputs.deploy-rs.defaultPackage.${system}
            ];
          };
        });

        darwinConfigurations = {
          macbook = inputs.nix-darwin.lib.darwinSystem {
            system = "aarch64-linux";
            modules = [
              ./darwin/macbook
              inputs.home-manager.darwinModules.home-manager
              ({ config, ... }: {
                home-manager = {
                  useUserPackages = true;
                  sharedModules = homeSharedModules;
                  extraSpecialArgs = [inputs.nix-colors];
                  users.${config.username}.imports = [ 
                    ./home/hosts/macbook
                    ({ pkgs, ... }: {
                      options.username = with pkgs.lib;
                        mkOption {
                          type = types.str;
                          default = config.username;
                          description = "The username of the user";
                        };
                    })
                  ] ++ homeManagerModules;
                };
              })
            ];
          };
        };

        nixosConfigurations = {
          desktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./nixos/desktop
              inputs.home-manager.nixosModules.home-manager
              ({ config, ... }: {
                home-manager = {
                  useUserPackages = true;
                  sharedModules = homeSharedModules;
                  extraSpecialArgs = {
                    nix-colors = inputs.nix-colors;
                    xremap-flake = inputs.xremap-flake;
                  };
                  users.${config.username}.imports = [
                    ./home/hosts/desktop
                    ({ pkgs, ... }: {
                      options.username = with pkgs.lib;
                        mkOption {
                          type = types.str;
                          default = config.username;
                          description = "The username of the user";
                        };
                    })
                  ] ++ homeManagerModulesExtended;
                };
              })
            ] ++ nixosModules;
          };

          server = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./nixos/server
              # microvm.nixosModules.microvm
            ] ++ nixosModules;
          };

          laptop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./nixos/laptop
              inputs.home-manager.nixosModules.home-manager
              ({ config, ... }: {
                home-manager = {
                  useUserPackages = true;
                  sharedModules = homeSharedModules;
                  extraSpecialArgs = {
                    nix-colors = inputs.nix-colors;
                    xremap-flake = inputs.xremap-flake;
                  };
                  users.${config.username}.imports = [
                    ./home/hosts/laptop
                    ({ pkgs, ... }: {
                      options.username = with pkgs.lib;
                        mkOption {
                          type = types.str;
                          default = config.username;
                          description = "The username of the user";
                        };
                    })
                  ] ++ homeManagerModulesExtended;
                };
              })
            ] ++ nixosModules;
          };
        };

        deploy.nodes.server = {
          hostname = "server.squeaker-eel.ts.net";
          fastConnection = true;
          profiles = {
            system = {
              sshUser = "admin";
              path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.server;
              user = "root";
            };
          };
        };
      };
}
