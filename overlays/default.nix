################################################################################
#
#  全局 Overlays 配置
#
#  这里导入所有的 Overlay 文件，用于修改或扩展 nixpkgs
#  Overlays 允许我们在不修改 nixpkgs 源码的情况下覆盖或添加软件包
#
################################################################################
[
  # Rime 输入法相关覆盖
  (import ./librime.nix)

  # 微信相关覆盖
  (import ./wechat.nix)

  # 导入自定义软件包 (pkgs/default.nix)
  (final: prev: {
    my-pkgs = import ../pkgs/default.nix { pkgs = final; };
  })
]
