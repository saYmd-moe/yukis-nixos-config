# Imported by: home/yuki/default.nix
{ config, pkgs, ... }:

{
  ################################################################################
  #
  #  Git 版本控制
  #
  ################################################################################

  programs.git.enable = true;

  programs.git.settings = {
    #enable = true;
    user.name = "saYmd-moe";
    user.email = "liuymyz@foxmail.com";
  };
}
