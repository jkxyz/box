{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  # Run system with qemu:
  # nix run .#nixosConfigurations.box.config.system.build.vm

  outputs = { self, nixpkgs, flake-utils }: {
    nixosConfigurations.box = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./modules/nixos/box/configuration.nix ];
    };
  };
}
