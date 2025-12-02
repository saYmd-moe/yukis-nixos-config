# 自定义软件包集合
#
# 这个文件用于定义或导入自定义的软件包
# 可以通过 pkgs.callPackage 来调用具体的包定义文件
#
{
  pkgs ? import <nixpkgs> { },
}:

{
  ################################################################################
  #
  #  自定义软件包列表
  #
  ################################################################################

  # Cider 3 音乐播放器 (需要手动放置 AppImage 文件)
  cider3 = pkgs.callPackage ./cider3/package.nix { };

  # WPS 365 教育版办公软件（自动下载） — 同时包含中文字体包
  # 当导入 wps365-edu 时，我们通过 callPackage 传入 chineseFonts 参数，
  # 以确保字体包也会出现在包的 closure 中（安装到 profile 时会一并包含）。
  wps365-edu =
    let
      chineseFonts = pkgs.callPackage ./wps365-edu/chinese-fonts.nix { };
    in
    pkgs.callPackage ./wps365-edu/package.nix { inherit chineseFonts; };

  # 示例：
  # my-package = pkgs.callPackage ./my-package { };
  # script-collection = pkgs.callPackage ./scripts { };
}
