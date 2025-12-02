# hosts/yuki-desktop/

包含 `yuki-desktop` 主机的系统 (NixOS) 配置。

## 系统概览

- **主机名**: `yuki-desktop`
- **架构**: x86_64-linux
- **桌面环境**: KDE Plasma 6 (`modules/nixos/desktop/kde.nix`)
- **显卡**: Intel Arc (`modules/nixos/hardware/arcgpu.nix`)
- **网络代理**: Daed (`modules/nixos/services/daed.nix`)
- **文件系统**: 包含 Windows NTFS 分区挂载 (`/mnt/windows`)

## 关键文件

- `default.nix`: 系统配置入口，导入了硬件配置和通用模块。
- `hardware-configuration.nix`: 硬件扫描结果（文件系统、内核模块）。
- `dae/`: 存放 Daed 相关的配置说明或辅助文件。

## 部署

```bash
# 在仓库根目录执行
./deploy.sh
```
