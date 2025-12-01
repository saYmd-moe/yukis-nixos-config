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

  # 相关硬件工具包
  environment.systemPackages = with pkgs; [
    lm_sensors
    liquidctl
    openrgb-with-all-plugins
  ];
}
