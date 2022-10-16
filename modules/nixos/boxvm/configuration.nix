{ inputs, ... }:

{
  imports = [ "${inputs.nixpkgs}/nixos/modules/virtualisation/qemu-vm.nix" ];

  system.stateVersion = "22.11";

  users.users.josh = {
    isNormalUser = true;
    password = "test";
    extraGroups = [ "wheel" ];
  };

  services.nginx.enable = true;

  virtualisation.forwardPorts = [{
    from = "host";
    host.port = 3000;
    guest.port = 80;
  }];

  networking.firewall.allowedTCPPorts = [ 80 ];
}
