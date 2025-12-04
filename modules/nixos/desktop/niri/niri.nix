# Imported by: hosts/yuki-desktop/default.nix
{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  ################################################################################
  #
  #  Niri
  #
  ################################################################################
  programs.niri = {
    enable = true;
  };

  # 使用 DMS 的 Polkit 集成，关闭 Niri 自带的 Polkit 服务（仅适用于 Niri nixOS Module）
  systemd.user.services."niri-flake-polkit".enable = false;
}
