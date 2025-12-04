# Imported by: home/yuki/default.nix
{
  niri,
  ...
}:

{

  programs.niri.settings = {
    # 环境变量
    environment = {
      "NIXOS_OZONE_WL" = "1";

      # 设置 Qt 平台主题为 qt6ct
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";

      # 设置语言为中文 UTF-8
      LANG = "zh_CN.UTF-8";

      # 设置默认输入法为 fcitx5
      XMODIFIERS = "@im=fcitx";
      QT_IM_MODULE = "fcitx";

      # 尝试解决部分软件的缩放问题
      # 令 QT 软件通过 wayland运行
      QT_QPA_PLATFORM = "wayland";
      # QT5 自动缩放
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      # QT5 分数缩放
      #QT_SCALE_FACTOR_ROUNDING_POLICY = "PassThrough"

      # 默认编辑器
      EDITOR = "nvim";
    };

    # 输入设备配置
    input = {
      # 键盘布局设置
      keyboard = {

        xkb = {
          layout = "us";
          variant = "";
          options = "caps:ctrl_modifier,ctrl:nocaps"; # 将 Caps Lock 键映射为 Ctrl 键
        };
        numlock = true;
      };

      # 鼠标设置
      mouse = { };
    };

    # 显示器配置
    outputs = { };

    # 自动运行的程序
    spawn-at-startup = [ ];

    # 布局配置
    layout = {
      gaps = 4;

      border = {
        enable = true;
        width = 2;
      };

      focus-ring = {
        enable = true;
        width = 4;
      };

    };

    # 光标主题
    cursor = {
      hide-after-inactive-ms = 2000;
      hide-when-typing = true;
      theme = "Catppuccin-Mocha-Mauve-Cursors";
    };

    # 窗口管理器配置

    window-rules = [
      # QQ
      {
        matches = [
          {
            app-id = "^QQ$";
          }
        ];
        excludes = [
          {
            app-id = "^QQ$";
            title = "^资料卡$";
          }
          {
            app-id = "^QQ$";
            title = "^图片查看器$";
          }
        ];
        default-column-width.proportion = 0.75;
      }

      {
        matches = [
          {
            app-id = "^QQ$";
            title = "^资料卡$";
          }
          {
            app-id = "^QQ$";
            title = "^图片查看器$";
          }
        ];
        open-floating = true;
      }

      # 微信
      {
        matches = [
          {
            app-id = "^WeChat$";
          }
        ];
        excludes = [
          {
            app-id = "^WeChat$";
            title = "^图片和视频$";
          }
        ];
        default-column-width.proportion = 0.75;
      }
      {
        matches = [
          {
            app-id = "^WeChat$";
            title = "^图片和视频$";
          }
        ];
        open-floating = true;
      }

      # 画中画窗口
      {
        matches = [
          {
            title = "^画中画$";
          }
        ];
        open-floating = true;
      }

      # Zotero
      {
        matches = [
          {
            app-id = "^Zotero$";
            title = "^进度$";
          }
        ];
        excludes = [
          {
            app-id = "^Zotero$";
            title = "^进度$";
          }
        ];
        open-maximized = true;
      }
      {
        matches = [
          {
            app-id = "^Zotero$";
            title = "^进度$";
          }
        ];
        open-floating = true;
        default-column-width.fixed = 400;
        default-window-height.fixed = 150;
        default-floating-position = {
          relative-to = "bottom-right";
          x = 20;
          y = 20;
        };
        open-focused = false;
        min-width = 400;
        max-width = 400;
        min-height = 150;
        max-height = 150;
      }
    ];

    # 按键绑定
    binds = {
      "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];

      "Mod+T" = {
        action.spawn = "ghostty";
        hotkey-overlay.title = "打开终端: ghostty";
      };
      "Mod+B".action.spawn = "microsoft-edge-stable";
      "Mod+E".action.spawn = "dolphin";
      "Super+Alt+L" = {
        action.spawn = [
          "dms"
          "ipc"
          "lock"
          "lock"
        ];
        hotkey-overlay.title = "锁定屏幕: dms ipc lock lock";
      };

      "XF86AudioRaiseVolume" = {
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "increment"
          "3"
        ];
        allow-when-locked = true;
      };
      "XF86AudioLowerVolume" = {
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "decrement"
          "3"
        ];
        allow-when-locked = true;
      };
      "XF86AudioMute" = {
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "mute"
        ];
        allow-when-locked = true;
      };
      "XF86AudioMicMute" = {
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "micmute"
        ];
        allow-when-locked = true;
      };

      "XF86MonBrightnessUp" = {
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "brightness"
          "increment"
          "5"
          ""
        ];
        allow-when-locked = true;
      };
      "XF86MonBrightnessDown" = {
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "brightness"
          "decrement"
          "5"
          ""
        ];
        allow-when-locked = true;
      };

      "Mod+TAB" = {
        action.toggle-overview = [ ];
        repeat = false;
      };

      "Mod+Q" = {
        action.close-window = [ ];
        repeat = false;
      };

      "Mod+Left".action.focus-column-left = [ ];
      "Mod+Down".action.focus-window-down = [ ];
      "Mod+Up".action.focus-window-up = [ ];
      "Mod+Right".action.focus-column-right = [ ];
      "Mod+H".action.focus-column-left = [ ];
      "Mod+L".action.focus-column-right = [ ];

      "Mod+Ctrl+Left".action.move-column-left = [ ];
      "Mod+Ctrl+Down".action.move-window-down = [ ];
      "Mod+Ctrl+Up".action.move-window-up = [ ];
      "Mod+Ctrl+Right".action.move-column-right = [ ];
      "Mod+Ctrl+H".action.move-column-left = [ ];
      "Mod+Ctrl+L".action.move-column-right = [ ];

      "Mod+J".action.focus-window-or-workspace-down = [ ];
      "Mod+K".action.focus-window-or-workspace-up = [ ];
      "Mod+Ctrl+J".action.move-window-down-or-to-workspace-down = [ ];
      "Mod+Ctrl+K".action.move-window-up-or-to-workspace-up = [ ];

      "Mod+Home".action.focus-column-first = [ ];
      "Mod+End".action.focus-column-last = [ ];
      "Mod+Ctrl+Home".action.move-column-to-first = [ ];
      "Mod+Ctrl+End".action.move-column-to-last = [ ];

      "Mod+Shift+Left".action.focus-monitor-left = [ ];
      "Mod+Shift+Down".action.focus-monitor-down = [ ];
      "Mod+Shift+Up".action.focus-monitor-up = [ ];
      "Mod+Shift+Right".action.focus-monitor-right = [ ];
      "Mod+Shift+H".action.focus-monitor-left = [ ];
      "Mod+Shift+J".action.focus-monitor-down = [ ];
      "Mod+Shift+K".action.focus-monitor-up = [ ];
      "Mod+Shift+L".action.focus-monitor-right = [ ];

      "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [ ];
      "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [ ];
      "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [ ];
      "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [ ];
      "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [ ];
      "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [ ];
      "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [ ];
      "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [ ];

      "Mod+Page_Down".action.focus-workspace-down = [ ];
      "Mod+Page_Up".action.focus-workspace-up = [ ];
      "Mod+U".action.focus-workspace-down = [ ];
      "Mod+I".action.focus-workspace-up = [ ];
      "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [ ];
      "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [ ];
      "Mod+Ctrl+U".action.move-column-to-workspace-down = [ ];
      "Mod+Ctrl+I".action.move-column-to-workspace-up = [ ];

      "Mod+Shift+Page_Down".action.move-workspace-down = [ ];
      "Mod+Shift+Page_Up".action.move-workspace-up = [ ];
      "Mod+Shift+U".action.move-workspace-down = [ ];
      "Mod+Shift+I".action.move-workspace-up = [ ];

      "Mod+WheelScrollDown" = {
        action.focus-workspace-down = [ ];
        cooldown-ms = 150;
      };
      "Mod+WheelScrollUp" = {
        action.focus-workspace-up = [ ];
        cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollDown" = {
        action.move-column-to-workspace-down = [ ];
        cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollUp" = {
        action.move-column-to-workspace-up = [ ];
        cooldown-ms = 150;
      };

      "Mod+WheelScrollRight".action.focus-column-right = [ ];
      "Mod+WheelScrollLeft".action.focus-column-left = [ ];
      "Mod+Ctrl+WheelScrollRight".action.move-column-right = [ ];
      "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [ ];

      "Mod+Shift+WheelScrollDown".action.focus-column-right = [ ];
      "Mod+Shift+WheelScrollUp".action.focus-column-left = [ ];
      "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = [ ];
      "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = [ ];

      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;

      "Mod+BracketLeft".action.consume-or-expel-window-left = [ ];
      "Mod+BracketRight".action.consume-or-expel-window-right = [ ];

      "Mod+Comma".action.consume-window-into-column = [ ];
      "Mod+Period".action.expel-window-from-column = [ ];

      "Mod+R".action.switch-preset-column-width = [ ];
      "Mod+Shift+R".action.switch-preset-window-height = [ ];
      "Mod+Ctrl+R".action.reset-window-height = [ ];
      "Mod+F".action.maximize-column = [ ];
      "Mod+Shift+F".action.fullscreen-window = [ ];
      "Mod+Ctrl+F".action.expand-column-to-available-width = [ ];

      "Mod+C".action.center-column = [ ];
      "Mod+Ctrl+C".action.center-visible-columns = [ ];

      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";

      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      "Mod+Backslash".action.toggle-window-floating = [ ];
      "Mod+Shift+Backslash".action.switch-focus-between-floating-and-tiling = [ ];

      "Mod+W".action.toggle-column-tabbed-display = [ ];

      "Print".action.screenshot = [ ];
      "Ctrl+Print".action.screenshot-screen = [ ];
      "Alt+Print".action.screenshot-window = [ ];

      "Mod+Escape" = {
        action.toggle-keyboard-shortcuts-inhibit = [ ];
        allow-inhibiting = false;
      };

      "Mod+Shift+E".action.quit = [ ];
      "Ctrl+Alt+Delete".action.quit = [ ];

      "Mod+Shift+P".action.power-off-monitors = [ ];

      "Mod+Space" = {
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "spotlight"
          "toggle"
        ];
        hotkey-overlay.title = "应用启动器";
      };
      "Mod+V" = {
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "clipboard"
          "toggle"
        ];
        hotkey-overlay.title = "剪贴板管理器";
      };
      "Mod+N" = {
        action.spawn = [
          "dms"
          "ipc"
          "call"
          "notepad"
          "toggle"
        ];
        hotkey-overlay.title = "记事本";
      };
    };

    # 杂七杂八的设置
    # 配置加载失败的通知将由 DMS 处理
    config-notification.disable-failed = true;
    prefer-no-csd = true;
    screenshot-path = "~/Pictures/Screenshots/Screenshot at %Y-%m-%d %H-%M-%S.png";
  };
}
