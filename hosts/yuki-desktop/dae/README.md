# config/dae/

用途：此仓库中使用的 `dae` / `daed` 的守护进程/应用程序特定配置。

如果 `daed` 需要静态文件、仪表板或无法表示为 Nix 选项的配置文件，请将它们保留在此处并从 `hosts/yuki-desktop/default.nix` 引用它们。

敏感值应在构建时从机密存储注入；不要将凭据提交到此目录。
