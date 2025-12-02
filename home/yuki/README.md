# home/yuki/

包含用户 `yuki` 的 Home Manager 配置。

关键文件：
- `default.nix` — 主要用户配置。此处管理的示例：
  - `programs.vscode.profiles.default.extensions` — 声明式管理的 VS Code 扩展列表。
  - `home.packages` — 用户级软件包，如浏览器和聊天应用。

提示：
- 将与机器无关的用户设置保留在此处。对于特定于机器的覆盖，请使用 `hosts/<host>/` 提供 extraSpecialArgs。
- 使用 `home.stateVersion` 锁定 Home Manager 兼容性（此仓库使用 `25.11`）。
