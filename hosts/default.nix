{ config, pkgs, ... }:

{
  ################################################################################
  #
  #  通用 NixOS 主机配置
  #
  #  这里放置所有主机共享的系统配置
  #
  ################################################################################

  # ------------------------------------------------------------------------------
  # Nix 基础设置
  # ------------------------------------------------------------------------------

  # 启用实验性功能 (Flakes)
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # 允许非自由软件
  nixpkgs.config.allowUnfree = true;

  # 导入全局 Overlays
  nixpkgs.overlays = import ../overlays;

  # ------------------------------------------------------------------------------
  # 本地化与时区
  # ------------------------------------------------------------------------------

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "zh_CN.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # ------------------------------------------------------------------------------
  # 基础系统软件包
  # ------------------------------------------------------------------------------

  environment.systemPackages = with pkgs; [
    # 核心工具
    vim
    wget
    git
    fish
    nixfmt-rfc-style
    direnv
  ];

  # 默认编辑器
  environment.variables.EDITOR = "vim";
}
