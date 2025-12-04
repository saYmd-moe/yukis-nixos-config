# Imported by: home/yuki/default.nix
{ config, pkgs, ... }:

{
  ################################################################################
  #
  #  VS Code 编辑器
  #
  ################################################################################

  programs.vscode = {
    enable = true;

    # 核心扩展 (由 NixOS 声明式管理)
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-python.python
      eamodio.gitlens
      yzhang.markdown-all-in-one

      mkhl.direnv # Direnv 支持

      # Nix 开发支持
      arrterian.nix-env-selector # 自动选择 Nix 环境
      jnoortheen.nix-ide
    ];
  };
}
