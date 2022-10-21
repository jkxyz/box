{ pkgs, config, inputs, ... }:

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

  services.openssh.extraConfig = ''
    PrintLastLog no
  '';

  programs.git = {
    enable = true;
    config = { init.defaultBranch = "main"; };
  };

  users.users.git = {
    uid = config.ids.uids.git;
    group = "git";
    shell = "${pkgs.git}/bin/git-shell";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFfcOdH0DX1wM+1UvZ3nBeKuGLyXv+TcHxFyONUaxhhb josh@sparrowhawk"
    ];
  };

  users.groups.git.gid = config.ids.gids.git;

  system.activationScripts = {
    boxInitialize.text = ''
      if [[ ! -d /box.git ]]; then
        mkdir -p /box.git
        cd /box.git
        ${pkgs.git}/bin/git init --bare
        chown --recursive git:git /box.git
      fi
    '';
  };
}
