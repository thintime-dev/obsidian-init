#!/bin/sh
# obsidian-init - 一键初始化 Obsidian 配置
# 用法: obsidian-init [源配置目录路径]

set -e  # 遇到错误立即退出

# 默认 .obsidian 配置源路径(即.obsidian 文件夹所在路径)
DEFAULT_SOURCE="$HOME/Projects/dotfiles/obsidian"

# 获取源路径（使用参数或默认值）
SOURCE="${1:-$DEFAULT_SOURCE}"

# 处理路径中的 ~ (用户可能传入带引号的 ~/path)
SOURCE="${SOURCE/#\~/$HOME}"

# 源 .obsidian 目录的完整路径
SOURCE_OBSIDIAN="$SOURCE/.obsidian"

# 目标路径为当前目录下的 .obsidian
TARGET="$PWD/.obsidian"

# 检查源 .obsidian 目录是否存在
if [ ! -d "$SOURCE_OBSIDIAN" ]; then
    echo "Error: 源配置目录不存在: $SOURCE_OBSIDIAN"
    exit 1
fi

# 检查目标 .obsidian 是否已存在
if [ -e "$TARGET" ]; then
    printf "Warning: 目标目录已存在 %s\n是否覆盖? [y/N] " "$TARGET"
    read -r confirm
    case "$confirm" in
        [yY]|[yY][eE][sS])
            rm -rf "$TARGET"
            ;;
        *)
            echo "已取消操作"
            exit 0
            ;;
    esac
fi

if cp -r "$SOURCE_OBSIDIAN" "$TARGET"; then
    echo "Success: .obsidian 配置已复制到 $PWD/.obsidian"
else
    echo "Error: 复制失败"
    exit 1
fi
