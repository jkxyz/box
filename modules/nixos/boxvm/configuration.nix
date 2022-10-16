{ inputs, ... }:

{
  imports = [ "${inputs.nixpkgs}/nixos/modules/virtualisation/qemu-vm.nix" ];

  system.stateVersion = "22.11";

  boot.loader.grub.enable = false;

  users.mutableUsers = false;
  users.users.root.password = "";

  services.sshd.enable = true;
  services.openssh.permitRootLogin = "yes";

  networking.firewall.allowedTCPPorts = [ 22 80 ];

  virtualisation.graphics = false;

  virtualisation.forwardPorts = [
    {
      from = "host";
      host.port = 3000;
      guest.port = 80;
    }
    {
      from = "host";
      host.port = 3022;
      guest.port = 22;
    }
  ];

  services.nginx = {
    enable = true;
    virtualHosts."localhost" = { root = "${inputs.self}/site"; };
  };
}
