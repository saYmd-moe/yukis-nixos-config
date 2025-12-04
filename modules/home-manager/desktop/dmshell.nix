# Imported by: home/yuki/default.nix
{ config, pkgs, ... }:

{
  ################################################################################
  #
  #  Niri
  #
  ################################################################################
  programs.niri = {
    enable = true;

  };

  ################################################################################
  #
  #  Dank Material Shell (DMShell)
  #
  ################################################################################

  programs.dankMaterialShell = {
    enable = true;

    niri = {
      enableKeybinds = true; # Automatic keybinding configuration
      enableSpawn = true; # Auto-start DMS with niri
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableClipboard = true; # Clipboard history manager
    enableVPN = true; # VPN management widget
    enableBrightnessControl = true; # Backlight/brightness controls
    enableColorPicker = true; # Color picker tool
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
    enableSystemSound = true; # System sound effects
  };

  # 使用 DMS 的 Polkit 集成，关闭 Niri 自带的 Polkit 服务（仅适用于 Niri nixOS Module）
  #systemd.user.services.niri-flake-polkit.enable = false;
}
