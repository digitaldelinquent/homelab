{
    description = "NixOS Configs";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.11";
        ghostty = {
            url = "github:ghostty-org/ghostty";
        };
    };
    outputs = { self, nixpkgs, home-manager, ghostty, ... }@inputs:
        let
            system = "x86_64-linux";
            lib = nixpkgs.lib;
        in {
        nixosConfigurations.homelab = lib.nixosSystem {
            inherit system;
            modules = [ ./configuration.nix ];
        };
    };

}
