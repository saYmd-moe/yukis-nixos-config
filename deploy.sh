#!/usr/bin/env bash
set -e

# 定义 Flake 目标 (根据当前目录的 flake.nix)
FLAKE_NAME="yuki-desktop"
TARGET_DIR="/etc/nixos"
# 创建临时目录用于验证构建
BUILD_DIR=$(mktemp -d)

# 脚本退出时清理临时目录
cleanup() {
  rm -rf "$BUILD_DIR"
}
trap cleanup EXIT

echo "� 准备构建环境..."
# 将当前目录复制到临时目录，排除 .git 目录
# 这样做是为了绕过 Nix Flakes 在 Git 仓库中只读取已暂存(staged)文件的限制
# 确保验证的是当前工作区中实际的文件内容
if command -v rsync &> /dev/null; then
    rsync -a --exclude='.git' --exclude='result' --exclude='.direnv' ./ "$BUILD_DIR/"
else
    cp -rf . "$BUILD_DIR/"
    rm -rf "$BUILD_DIR/.git" "$BUILD_DIR/result"
fi

echo " [1/2] 正在验证系统构建 (Dry Run)..."
echo "执行: (cd $BUILD_DIR && nixos-rebuild build --flake .#$FLAKE_NAME )"

# 尝试构建系统配置
# 进入临时目录构建，这样生成的 'result' 链接会被自动清理
if (cd "$BUILD_DIR" && nixos-rebuild build --flake ".#$FLAKE_NAME"); then
    echo "✅ 构建验证成功！配置有效。"
else
    echo "❌ 构建失败。请修复错误后再试。"
    exit 1
fi

echo "📦 [2/2] 正在将配置写入 $TARGET_DIR ..."

# 确保目标目录存在
if [ ! -d "$TARGET_DIR" ]; then
    echo "创建 $TARGET_DIR..."
    sudo mkdir -p "$TARGET_DIR"
fi

# 检查是否安装了 rsync，推荐使用 rsync 进行同步
if command -v rsync &> /dev/null; then
    echo "使用 rsync 同步文件 (排除 .git, result, .direnv, deploy.sh)..."
    # -a: 归档模式
    # -v: 详细输出
    # --delete: 删除目标目录中源目录不存在的文件 (保持完全一致)
    # --chown=root:root: 强制所有者为 root
    # --chmod=D755,F644: 设置目录权限 755，文件权限 644
    sudo rsync -av --delete \
        --exclude='.git' \
        --exclude='result' \
        --exclude='.direnv' \
        --exclude='.github' \
        --exclude='deploy.sh' \
        --chown=root:root \
        --chmod=D755,F644 \
        ./ "$TARGET_DIR/"
else
    echo "⚠️ 未检测到 rsync，使用 cp 复制 (建议安装 rsync 以获得更好体验)..."
    # 复制所有文件
    sudo cp -rf . "$TARGET_DIR/"
    
    # 清理不需要的文件
    echo "清理目标目录中的临时文件..."
    [ -L "$TARGET_DIR/result" ] && sudo rm "$TARGET_DIR/result"
    [ -f "$TARGET_DIR/deploy.sh" ] && sudo rm "$TARGET_DIR/deploy.sh"
    
    # 尝试修复权限
    echo "修复权限..."
    sudo chown -R root:root "$TARGET_DIR"
    sudo chmod -R u=rwX,go=rX "$TARGET_DIR"
fi

echo "✨ 成功！所有配置文件已更新到 $TARGET_DIR"
echo "💡 你现在可以运行 'sudo nixos-rebuild switch' 来应用更改。"
