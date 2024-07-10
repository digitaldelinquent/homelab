{
    description = "Homelab";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";
    };
    outputs = { self, nixpkgs, ... }:
        let
            lib = nixpkgs.lib;
        in {
        nixosConfigurations = {
            homelab = lib.nixosSystem {
                system = "x86_64-linux";
                modules = [ ./hosts/homelab ];
            };
        };
    };

}
