# Imported by: hosts/yuki-desktop/default.nix
{ config, pkgs, ... }:

{
  ################################################################################
  #
  #  音频服务 (PipeWire)
  #
  ################################################################################

  # 禁用 PulseAudio，使用 PipeWire 替代
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # 如果需要 JACK 支持，请取消注释
    jack.enable = true;
  };
}
