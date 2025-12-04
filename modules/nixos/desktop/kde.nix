# Imported by: hosts/yuki-desktop/default.nix
{ config, pkgs, ... }:

{
  ################################################################################
  #
  #  桌面环境 (KDE Plasma)
  #
  ################################################################################

  # 启用 X11 显示服务
  services.xserver.enable = true;

  # 启用 SDDM 显示管理器和 Plasma 6 桌面环境
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # X11 键盘映射
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # 启用触摸板支持
  # services.xserver.libinput.enable = true;
}
