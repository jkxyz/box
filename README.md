```
$ nix run .#nixosConfigurations.boxvm.config.system.build.vm
$ NIX_SSHOPTS="-p 3022" nixos-rebuild switch --flake .#boxvm --target-host root@localhost
```
