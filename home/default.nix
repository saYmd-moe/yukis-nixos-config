{ config, pkgs, ... }:

{
  ################################################################################
  #
  #  通用 Home Manager 配置
  #
  #  这里放置所有用户共享的配置
  #
  ################################################################################

  # 启用 Git
  programs.git.enable = true;

  # 使用英文 xdg-user-dirs
  xdg.userDirs = {
    enable = true;
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = "${config.home.homeDirectory}/Music";
    pictures = "${config.home.homeDirectory}/Pictures";
    videos = "${config.home.homeDirectory}/Videos";
    desktop = "${config.home.homeDirectory}/Desktop";
  };

}
