{ config, pkgs, ... }:

{
  imports = [
    # 导入通用 Home 配置
    ../default.nix
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

    # --- 通讯与社交 ---
    qq
    wechat

    # --- 网络浏览器 ---
    microsoft-edge

    # --- 多媒体 ---
    my-pkgs.cider3
  ];

  ################################################################################
  #
  #  开发环境配置
  #
  ################################################################################

  # Git 版本控制 (enable = true 已在 home/default.nix 中设置)
  programs.git = {
    userName = "saYmd-moe";
    userEmail = "liuymyz@foxmail.com";
  };

  # VS Code 编辑器
  programs.vscode = {
    enable = true;

    # 核心扩展 (由 NixOS 声明式管理)
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-python.python
      eamodio.gitlens
      yzhang.markdown-all-in-one

      # Nix 开发支持
      arrterian.nix-env-selector # 自动选择 Nix 环境
      jnoortheen.nix-ide
    ];

  };

  ################################################################################
  #
  #  状态版本
  #
  ################################################################################
  # ⚠️ 切勿随意更改此版本号，它决定了 Home Manager 的状态兼容性
  home.stateVersion = "25.05";
}
