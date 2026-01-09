#!/bin/sh
# obsidian-init - 一键初始化 Obsidian 配置
# 用法: obsidian-init [源配置目录路径]

# 默认 .obsidian 配置源路径(即.obsidian 文件夹所在路径)
DEFAULT_SOURCE="~/Projects/dotfiles/obsidian"

# 获取源路径（使用参数或默认值）
SOURCE="${1:-$DEFAULT_SOURCE}"

# 源 .obsidian 目录的完整路径
SOURCE_OBSIDIAN="$SOURCE/.obsidian"

# 目标路径为当前目录下的 .obsidian
TARGET="$(pwd)/.obsidian"

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

cp -r "$SOURCE_OBSIDIAN" "$TARGET"

if [ $? -eq 0 ]; then
    echo "Success: .obsidian 配置已复制到 $(pwd)/.obsidian"
else
    echo "Error: 复制失败"
    exit 1
fi
