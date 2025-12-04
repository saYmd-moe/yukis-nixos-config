# Imported by: hosts/yuki-desktop/default.nix
{ config, pkgs, ... }:

{
  ################################################################################
  #
  #  字体配置
  #
  ################################################################################

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    lxgw-wenkai
    lxgw-wenkai-screen
    lxgw-neoxihei
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    wqy_zenhei
  ];
}
