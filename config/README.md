# config/

用途：杂项配置片段和辅助数据。此仓库包含用于 `daeuniverse` flake 输入的 dae/daed 相关配置 `config/dae/`。

将非 Nix 资产和小型辅助脚本保留在此处。避免将机密信息放入此目录。

示例：
- `config/dae/` — `daed` 服务读取的额外文件或与其交互的脚本。
