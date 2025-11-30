# hosts/yuki-desktop/

包含 `yuki-desktop` 主机的系统 (NixOS) 配置。

关键文件：
- `default.nix` — 以前是 `configuration.nix`。由 `flake.nix` 导入并设置系统服务（桌面、音频、网络、overlays）。
- `hardware-configuration.nix` — 由 `nixos-generate-config` 生成的硬件特定设置。

此文件中的重要模式：
- `nixpkgs.overlays` 用于内联覆盖 `librime` 并添加 Lua/JIT 插件。
- `services.daed` 通过 `daeuniverse` flake 输入启用。

如果需要将系统配置拆分为模块，请将它们放在 `modules/nixos/` 下，并从 `hosts/yuki-desktop/default.nix` 导入。
