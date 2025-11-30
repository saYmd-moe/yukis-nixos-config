# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # 导入硬件扫描配置
    ./hardware-configuration.nix
  ];

  ################################################################################
  #
  #  文件系统与存储
  #
  ################################################################################

  # 挂载 Windows NTFS 分区
  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/EA9572B0D459FB63";
    fsType = "ntfs3";
    options = [
      "rw"
      "uid=1000"
      "gid=100"
      "dmask=0022"
      "fmask=0133"
      "nofail"
    ];
  };

  ################################################################################
  #
  #  系统引导与内核
  #
  ################################################################################

  # 启用 systemd-boot 引导加载程序
  boot.loader.systemd-boot.enable = true;

  # EFI 配置
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # 使用最新的 Linux 内核
  boot.kernelPackages = pkgs.linuxPackages_latest;

  ################################################################################
  #
  #  网络配置
  #
  ################################################################################

  networking.hostName = "yuki-desktop"; # 主机名

  # 启用 NetworkManager 网络管理工具
  networking.networkmanager.enable = true;

  # 代理设置 (如有需要可取消注释)
  #networking.proxy.default = "http://192.168.31.157:2080";
  #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  ################################################################################
  #
  #  本地化与时区
  #
  ################################################################################

  # 时区设置
  time.timeZone = "Asia/Shanghai";

  # 语言环境设置
  i18n.defaultLocale = "zh_CN.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  ################################################################################
  #
  #  桌面环境 (KDE Plasma)
  #
  ################################################################################

  # 启用 X11 显示服务
  services.xserver.enable = true;

  # 启用 SDDM 显示管理器和 Plasma 6 桌面环境
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # X11 键盘映射
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };

  # 启用触摸板支持
  # services.xserver.libinput.enable = true;

  ################################################################################
  #
  #  硬件服务 (打印/散热/RGB)
  #
  ################################################################################

  # 打印服务 (CUPS)
  services.printing.enable = true;

  # 风扇控制 (CoolerControl)
  programs.coolercontrol.enable = true;

  # OpenRGB 灯光控制
  services.hardware.openrgb.enable = true;

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

  ################################################################################
  #
  #  用户配置
  #
  ################################################################################

  users.users.yuki = {
    isNormalUser = true;
    description = "MercuryMoe";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      # 系统级用户软件 (建议在 home-manager 中管理)
      #kdePackages.kate
      #thunderbird
    ];
  };

  # 允许 wheel 组用户免密 sudo
  security.sudo.wheelNeedsPassword = false;

  ################################################################################
  #
  #  系统软件包与环境
  #
  ################################################################################

  # 允许非自由软件 (Unfree)
  nixpkgs.config.allowUnfree = true;

  # 导入 Overlays
  nixpkgs.overlays = import ../../overlays;

  # 启用实验性功能 (Flakes)
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # 系统级软件包
  environment.systemPackages = with pkgs; [
    # --- 核心工具 ---
    vim
    wget
    git
    fish
    refind
    nixfmt-rfc-style # Nix 代码格式化

    # --- 美化 ---
    papirus-icon-theme

    # --- 硬件监控与控制 ---
    lm_sensors
    liquidctl
    openrgb-with-all-plugins
  ];

  # 默认编辑器
  environment.variables.EDITOR = "vim";

  ################################################################################
  #
  #  游戏与娱乐 (Steam)
  #
  ################################################################################

  programs.steam = {
    enable = true;
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

  ################################################################################
  #
  #  网络代理 (Daed)
  #
  ################################################################################

  # Daed: 带 Web 管理面板的透明代理工具
  services.daed = {
    enable = true;
    openFirewall = {
      enable = true;
      port = 12345; # Web 面板端口
    };
  };

  # (已注释) Dae 纯配置模式备份
  #services.dae = { ... };

  ################################################################################
  #
  #  字体与输入法
  #
  ################################################################################

  # 字体配置
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

  # 输入法 (Fcitx5 + Rime)
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-gtk
      kdePackages.fcitx5-qt
      fcitx5-nord
    ];
  };

  ################################################################################
  #
  #  系统状态版本
  #
  ################################################################################

  # ⚠️ 此选项定义了系统状态的兼容性版本，请勿随意更改
  system.stateVersion = "25.05";

}
