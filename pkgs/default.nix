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

  # 示例：
  # my-package = pkgs.callPackage ./my-package { };
  # script-collection = pkgs.callPackage ./scripts { };
}
