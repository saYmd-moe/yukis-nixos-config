# Yuki's NixOS Configuration

此仓库包含 `yuki-desktop` 机器的 NixOS 和 Home Manager 配置。
基于 Flake 架构，采用模块化设计。

## 🚀 快速开始

### 部署配置

推荐使用 `deploy.sh` 脚本，它会先进行 Dry Run 验证，然后同步到 `/etc/nixos` 并应用。

```bash
./deploy.sh
```

或者手动应用：

```bash
sudo nixos-rebuild switch --flake .#yuki-desktop
```

### 更新依赖

```bash
nix flake update
```

## 📂 目录结构

- **`flake.nix`**: 项目入口，定义输入源（nixpkgs, home-manager, daeuniverse）和系统输出。
- **`hosts/`**: 主机级系统配置。
  - `yuki-desktop/`: 主要工作站配置 (KDE, Intel Arc, Daed)。
- **`home/`**: 用户级 Home Manager 配置。
  - `yuki/`: 用户 `yuki` 的配置 (VS Code, Git, Shell)。
- **`modules/`**: 可重用的 NixOS 和 Home Manager 模块。
  - `nixos/`: 系统模块 (Desktop, Hardware, Services)。
  - `home-manager/`: 用户模块 (Programs, Desktop)。
- **`pkgs/`**: 自定义软件包。
  - `wps365-edu`: WPS Office 365 教育版（含中文字体修复）。
  - `cider3`: Apple Music 客户端。
- **`overlays/`**: Nixpkgs 覆盖层，用于注入自定义包和修复。

## 🛠️ 主要功能

- **桌面**: KDE Plasma 6，配合 Fcitx5 输入法。
- **硬件**: 针对 Intel Arc 显卡优化，支持 PipeWire 音频。
- **网络**: 集成 Daed 透明代理服务。
- **办公**: 预装修复版 WPS Office 365。
- **开发**: 配置了 VS Code, Git, Fish Shell 等开发环境。

查看每个子目录中的 `README.md` 以获取更多详细信息。
