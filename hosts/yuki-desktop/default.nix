# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Mount Windows drive
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

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  # 指定 EFI 挂载点 (通常默认就是 /boot，显式写出来更保险)
  boot.loader.efi.efiSysMountPoint = "/boot";
  # 安装 refind 包，以便我们可以运行 refind-install 命令
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "yuki-desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  #networking.proxy.default = "http://192.168.31.157:2080";
  #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable fan control
  programs.coolercontrol.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yuki = {
    isNormalUser = true;
    description = "MercuryMoe";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      #kdePackages.kate
      #thunderbird
    ];
  };
  security.sudo.wheelNeedsPassword = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = import ../../overlays;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = with pkgs; [
    # 命令行工具
    vim
    wget
    git
    fish
    refind
    nixfmt-rfc-style # Nix 代码格式化工具

    # 透明代理
    #dae

    # 美化
    papirus-icon-theme

    # 主板传感器和水冷支持
    lm_sensors
    liquidctl
    openrgb-with-all-plugins
  ];

  # Steam 配置
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  # Link Steam library from Windows drive
  systemd.tmpfiles.rules = [
    "d /home/yuki/.local/share/Steam 0755 yuki users -"
    "d /home/yuki/.local/share/Steam/steamapps 0755 yuki users -"
    "d /home/yuki/.local/share/Steam/steamapps/common 0755 yuki users -"
  ];

  #TODO dae 配置问题仍然解决不了，目前推测是因为筛选器的问题 filter，暂时切换回 daed
  # dae - declarative configuration
  # 组合并复制 dae 配置文件
  #environment.etc."dae/config.dae" = {
  #  text =
  #    builtins.readFile ../../secrets/dae/dae-subscription.dae
  #    + "\n"
  #    + builtins.readFile ./dae/config.dae;
  #  mode = "0600";
  #};
  #environment.etc."dae/boostnet.sub" = {
  #  text = builtins.readFile ../../secrets/dae/boostnet.txt;
  #};

  #services.dae = {
  #  enable = true;
  #  configFile = "/etc/dae/config.dae";
  #  openFirewall = {
  #    enable = true;
  #    port = 12345;
  #  };

  #assets = with pkgs; [
  #  v2ray-geoip
  #  v2ray-domain-list-community
  #];

  # alternative of `assets`, a dir contains geo database.
  #assetsPath = "/etc/dae";
  #};

  # daed - dae with a web dashboard (Optional: disable if using dae directly)
  services.daed = {
    enable = true;
    openFirewall = {
      enable = true;
      port = 12345;
    };
  };

  services.hardware.openrgb.enable = true;

  # System Environment
  environment.variables.EDITOR = "vim";

  # Fonts configuration
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
    wqy_zenhei # WenQuanYi Zen Hei, a popular Chinese font
  ];

  # Input method fcitx5
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-gtk # GTK 支持
      kdePackages.fcitx5-qt
      fcitx5-nord
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
