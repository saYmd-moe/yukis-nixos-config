# modules/

用途：托管在仓库内维护的可重用 NixOS 和 Home Manager 模块。

## 现有模块列表

### NixOS 模块 (`modules/nixos/`)

#### Desktop
- `desktop/kde.nix`: KDE Plasma 6 桌面环境配置。
- `desktop/fonts.nix`: 系统字体配置。
- `desktop/input-method/fcitx5.nix`: Fcitx5 输入法及词库配置。

#### Hardware
- `hardware/arcgpu.nix`: Intel Arc 显卡驱动与硬件加速配置。
- `hardware/audio.nix`: PipeWire 音频服务配置。
- `hardware/peripherals.nix`: 外设配置（如罗技鼠标等）。

#### Services
- `services/daed.nix`: Daed 代理服务（基于 eBPF）。
- `services/steam.nix`: Steam 游戏平台及兼容层配置。

### Home Manager 模块 (`modules/home-manager/`)

#### Programs
- `programs/git.nix`: Git 用户配置。
- `programs/vscode.nix`: VS Code 扩展与设置。

#### Desktop
- `desktop/fontconfig.nix`: 用户级字体渲染配置。

## 使用方法

在 `hosts/*/default.nix` 或 `home/*/default.nix` 中导入：

```nix
imports = [
  ../../modules/nixos/desktop/kde.nix
  ../../modules/nixos/services/daed.nix
];
```
