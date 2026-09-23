{
  description = "vesper-nubilosus";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:Nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
    
    millennium = {
      url = "git+https://github.com/SteamClientHomebrew/Millennium?dir=packages/nix";
    };
  };

  outputs = { self, nixpkgs, home-manager, millennium, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/nixos/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
	    home-manager.backupFileExtension = "bak";
	    home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.vespera = import ./home/home.nix;
          }
        ];
      };
    };
  };
}
