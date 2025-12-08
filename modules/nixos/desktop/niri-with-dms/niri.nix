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

  # 装上一些 Niri 和 dms 需要的（美化）软件
  environment.systemPackages = with pkgs; [
    # --- x11 支持 ---
    xwayland-satellite

    # --- 美化 ---
    papirus-icon-theme
    catppuccin-cursors.mochaMauve
    adw-gtk3
    adwaita-qt
  ];

  programs.niri = {
    enable = true;
  };

  systemd.user.services.niri-flake-polkit.enable = false;
}
