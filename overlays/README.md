# overlays/

用途：存储 nixpkgs overlay 文件，用于修改上游软件包或添加自定义包。

## 包含的 Overlays

- **`default.nix`**: 入口文件，组合了所有其他 overlay。
- **`librime.nix`**: 覆盖 `librime` 库（可能用于输入法兼容性）。
- **`wechat.nix`**: 微信相关的修复或调整。
- **`pkgs` (在 default.nix 中内联)**: 引入 `pkgs/` 目录下的自定义软件包（如 `wps365-edu`, `cider3`）到 `pkgs.my-pkgs` 命名空间。

## 使用方法

此仓库在 `hosts/default.nix` 或 `hosts/yuki-desktop/default.nix` 中通过 `nixpkgs.overlays` 导入：

```nix
nixpkgs.overlays = import ../overlays;
```
