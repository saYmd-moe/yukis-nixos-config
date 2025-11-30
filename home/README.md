# home/

用途：存储每个用户的 Home Manager 配置。每个用户都有一个包含其 Home Manager `default.nix` 的目录。

此仓库使用：
- `home/yuki/default.nix` — 用户 `yuki` 的 Home Manager 配置（VS Code 扩展、软件包、stateVersion 等）。

注意和示例：
- Home Manager 作为 NixOS 模块包含在 `flake.nix` 中（`home-manager.nixosModules.home-manager`）。
- 您可以通过 `home-manager.extraSpecialArgs` 从 `flake.nix` 向导入的 `home/*/default.nix` 传递额外参数。

如果单独应用用户配置（如果您使用独立的 home-manager）：

```bash
home-manager switch --flake .#yuki
```
