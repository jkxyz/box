{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: {
    nixosConfigurations = {
      box = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./modules/nixos/box/configuration.nix ];
      };

      # A NixOS system intended to be run as a VM for testing.
      # To run with QEMU:
      # $ nix run .#nixosConfigurations.boxvm.config.system.build.vm
      boxvm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./modules/nixos/boxvm/configuration.nix ];
      };
    };
  };
}
