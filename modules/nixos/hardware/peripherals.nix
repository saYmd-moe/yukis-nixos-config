# Imported by: hosts/yuki-desktop/default.nix
{ config, pkgs, ... }:

{
  ################################################################################
  #
  #  硬件服务 (打印/散热/RGB)
  #
  ################################################################################

  # 打印服务 (CUPS)
  services.printing.enable = true;

  # 风扇控制 (CoolerControl)
  programs.coolercontrol.enable = true;

  # OpenRGB 灯光控制
  services.hardware.openrgb.enable = true;

  # 自动挂载支持 (gvfs + udisks2)
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # 蓝牙支持
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # 相关硬件工具包
  environment.systemPackages = with pkgs; [
    lm_sensors
    liquidctl
    openrgb-with-all-plugins
  ];
}
