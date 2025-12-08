# Imported by: flake.nix
{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # 导入通用 Home 配置
    ../default.nix

    # 导入模块化 Home Manager 配置
    ../../modules/home-manager/programs/git.nix
    ../../modules/home-manager/programs/vscode.nix
    ../../modules/home-manager/programs/obs-studio.nix

    # 导入字体配置
    ../../modules/home-manager/desktop/fontconfig.nix

    # 导入桌面环境配置
    ../../modules/home-manager/desktop/niri-with-dms/niri.nix
    ../../modules/home-manager/desktop/niri-with-dms/dmshell.nix
  ];

  ################################################################################
  #
  #  基础用户信息
  #
  ################################################################################
  home.username = "yuki";
  home.homeDirectory = "/home/yuki";

  ################################################################################
  #
  #  用户软件包管理
  #
  ################################################################################
  home.packages = with pkgs; [
    # --- 生产力工具 ---
    inkscape
    zotero
    obsidian
    my-pkgs.wps365-edu

    # --- 通讯与社交 ---
    qq
    wechat

    # --- 网络浏览器 ---
    microsoft-edge

    # --- 多媒体 ---
    my-pkgs.cider3

    # --- 开发工具 ---
    ghostty

    # --- 系统配置 ---
    udiskie # 自动挂载工具
    kdePackages.qt6ct

    # --- 基本工具 ---
    nautilus
    kdePackages.dolphin
    kdePackages.dolphin-plugins

    # --- 美化 ---
    catppuccin-cursors.mochaMauve

    # --- wine ---
    wineWowPackages.waylandFull
    winetricks
    bottles
  ];

  ################################################################################
  #
  #  部分软件配置
  #
  ################################################################################

  ################################################################################
  #
  #  状态版本
  #
  ################################################################################
  # ⚠️ 切勿随意更改此版本号，它决定了 Home Manager 的状态兼容性
  home.stateVersion = "25.11";
}
