{ inputs, ... }:

{
  imports = [ "${inputs.nixpkgs}/nixos/modules/virtualisation/qemu-vm.nix" ];

  system.stateVersion = "22.11";

  users.users.josh = {
    isNormalUser = true;
    password = "test";
    extraGroups = [ "wheel" ];
  };

  services.nginx = {
    enable = true;

    virtualHosts."localhost" = { root = "${inputs.self}/site"; };
  };

  virtualisation.forwardPorts = [{
    from = "host";
    host.port = 3000;
    guest.port = 80;
  }];

  virtualisation.graphics = false;

  networking.firewall.allowedTCPPorts = [ 80 ];
}
