# modules/

用途：托管在仓库内维护的可重用 NixOS 和 Home Manager 模块。

常见用法：
- `modules/nixos/` — 可由 `hosts/*/default.nix` 导入的可重用系统模块（例如 `desktop.nix`、`wireguard.nix`）。
- `modules/home-manager/` — 用于常见用户配置模式的可重用 home-manager 模块。

为什么使用模块：
- 保持主机 `default.nix` 简短且高级。
- 鼓励跨多台机器或用户重用。

`hosts/yuki-desktop/default.nix` 中的导入示例：

```nix
# ...existing code...
imports = [
  ./hardware-configuration.nix
  ../modules/nixos/desktop.nix
];
```
