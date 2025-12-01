{ config, pkgs, ... }:

{
  ################################################################################
  #
  #  游戏与娱乐 (Steam)
  #
  ################################################################################

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true; # 启用 Gamescope 会话支持
    remotePlay.openFirewall = true; # 开放远程畅玩端口
    dedicatedServer.openFirewall = true; # 开放专用服务器端口
    localNetworkGameTransfers.openFirewall = true; # 开放局域网传输端口
  };

  # 链接 Windows 盘的 Steam 库
  systemd.tmpfiles.rules = [
    "d /home/yuki/.local/share/Steam 0755 yuki users -"
    "d /home/yuki/.local/share/Steam/steamapps 0755 yuki users -"
    "d /home/yuki/.local/share/Steam/steamapps/common 0755 yuki users -"
  ];
}
