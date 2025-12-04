# Imported by: hosts/yuki-desktop/default.nix
{ config, pkgs, ... }:

{
  ################################################################################
  #
  #  网络代理 (Daed)
  #
  ################################################################################

  # Daed: 带 Web 管理面板的透明代理工具
  services.daed = {
    enable = true;
    openFirewall = {
      enable = true;
      port = 12345; # Web 面板端口
    };
  };
}
