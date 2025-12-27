{
    description = "NixOS Configs";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.11";
    };
    outputs = { self, nixpkgs, ... }@inputs:
        let
            system = "x86_64-linux";
            lib = nixpkgs.lib;
        in {
        nixosConfigurations.homelab = lib.nixosSystem {
            inherit system;
            modules = [ nix/configuration.nix ];
        };
    };

}
