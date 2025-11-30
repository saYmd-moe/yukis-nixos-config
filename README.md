# yukis-nixos-config

此仓库包含 `yuki-desktop` 机器的 NixOS 和 Home Manager 配置。
它采用了受常见入门配置（如模块化的 `nixos/`、`home-manager/`、`modules/`、`overlays/`）启发的拆分布局。

快速命令

- 通过 flake 应用系统和 Home Manager 配置：

```bash
./deploy.sh
sudo nixos-rebuild switch --flake .#yuki-desktop
```

- 更新 flake 输入源：

```bash
nix flake update
```

布局亮点

- `flake.nix` — 中心入口点，连接模块和 home-manager 用户。
- `hosts/` — 每个主机的系统配置（此仓库使用 `hosts/yuki-desktop`）。
- `home/` — 每个用户的 home-manager 配置。
- `modules/` — 本地维护的可重用 NixOS / home-manager 模块。
- `overlays/` — nixpkgs overlays（自定义软件包、librime 覆盖等）。
- `pkgs/` — 如果需要，在此处添加仓库内的软件包表达式。

查看每个目录中的 README 以获取更多详细信息和示例。
