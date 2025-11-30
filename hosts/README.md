# hosts/

用途：存储每个主机的 NixOS 系统配置。每个主机都是一个包含 `default.nix`（或 `configuration.nix`）和任何硬件特定文件的文件夹。

此仓库使用：
- `hosts/yuki-desktop/default.nix` — `yuki-desktop` 机器的主要系统配置。
- `hosts/yuki-desktop/hardware-configuration.nix` — 自动生成的硬件文件（从根目录移动至此）。

为什么使用此布局：它使多主机管理变得简单，并反映了社区配置中的常见模式。

如何应用（从仓库根目录）：

```bash
sudo nixos-rebuild switch --flake .#yuki-desktop
```

注意：
- 将主机特定的机密信息保存在仓库之外（例如，密封或从机密管理器获取）。
- 如果创建新主机，请在 `hosts/` 下添加新目录，并在必要时更新 `flake.nix`。
