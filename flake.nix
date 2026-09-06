{
	description = "hasher's nixos configuration";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.11";
		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }: {
		nixosConfigurations.eiko = nixpkgs.lib.nixosSystem {
			system = "x84_64-linux";
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.therootdaemon = import ./home.nix;
						backupFileExtension = "backup";
					};
				}
			];
		};
	};
}
