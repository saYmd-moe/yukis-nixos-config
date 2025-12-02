# pkgs/

用途：本地软件包表达式（如果您需要添加仓库内派生而不是发布到 flake 输入）。

## 包含的软件包

### 1. WPS Office 365 教育版 (`wps365-edu`)
参考  Beriholic/nix-wpsoffice-cn
- **路径**: `pkgs/wps365-edu/package.nix`
- **描述**: WPS Office 365 教育版，包含防盗链下载逻辑和自动补丁。
- **特性**:
  - 自动集成中文字体包 (`chinese-fonts.nix`)。
  - 修复了 `.desktop` 文件以正确显示名称 "WPS" 和图标。
  - 移除了多余的组件入口，仅保留主程序。
  - 解决了 `libbz2.so` 断链和 `libmysqlclient` 缺失问题。

### 2. Cider 3 (`cider3`)
- **路径**: `pkgs/cider3/package.nix`
- **描述**: Apple Music 第三方客户端 (AppImage 包装)。

## 使用方法

这些软件包通过 `overlays/default.nix` 暴露在 `pkgs.my-pkgs` 下。
例如，在 `home.nix` 或 `configuration.nix` 中使用：

```nix
environment.systemPackages = [
  pkgs.my-pkgs.wps365-edu
  pkgs.my-pkgs.cider3
];
```
