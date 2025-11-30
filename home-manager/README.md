# home-manager/

用途：home-manager 相关的每个用户目录和可重用 home-manager 模块的容器。

结构建议：
- `home-manager/<user>/default.nix` — 用户配置（此仓库使用 `home/yuki/default.nix` 代替）。
- `modules/home-manager/` — 可由用户配置导入的可重用 home-manager 模块。

此仓库目前将用户配置保存在 `home/` 中，并使用 `home-manager/` 作为未来扩展的覆盖层。
