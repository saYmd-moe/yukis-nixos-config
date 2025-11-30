{ config, pkgs, ... }:

{
  home.username = "yuki";
  home.homeDirectory = "/home/yuki";

  home.packages = with pkgs; [
    # 其他工具
    inkscape

    # 通讯工具
    qq
    wechat

    # 浏览器
    microsoft-edge
  ];

  # git 相关配置
  programs.git = {
    enable = true;
    userName = "saYmd-moe";
    userEmail = "liuymyz@foxmail.com";
  };

  # VScode 配置
  programs.vscode = {
    enable = true;

    # 核心扩展交由 NixOS 管理
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-python.python
      eamodio.gitlens
      yzhang.markdown-all-in-one

      # Nix 语言支持
      #bbenoist.nix              # Nix language syntax highlighting
      arrterian.nix-env-selector # 选择 Nix 环境
      jnoortheen.nix-ide
    ];

  };

  # 控制版本在 25.05
  home.stateVersion = "25.05";
}
