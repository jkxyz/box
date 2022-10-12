{ config, lib, pkgs, ... }:

{
  system.stateVersion = "22.11";

  users.users.josh = {
    isNormalUser = true;
    password = "test";
  };
}
