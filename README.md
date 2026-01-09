# obsidian-init

一键初始化 Obsidian 配置的轻量级脚本工具。

## Features

- 将预设的 `.obsidian` 配置文件夹复制到当前目录
- 支持自定义配置源路径
- 跨平台支持：Linux/macOS (POSIX shell) 和 Windows (PowerShell)
- 内存占用极低

## Installer

### Linux / macOS

```bash
git clone https://github.com/thintime-dev/obsidian-init.git
cd obsidian-init
chmod +x obsidian-init.sh
```

添加别名到 shell 配置文件

**Bash**
```bash
echo "alias obsidian-init=\"$(pwd)/obsidian-init.sh\"" >> ~/.bashrc
source ~/.bashrc
```

**Zsh**
```bash
echo "alias obsidian-init=\"$(pwd)/obsidian-init.sh\"" >> ~/.zshrc
source ~/.zshrc
```

**Fish**
```fish
echo "alias obsidian-init=\"$(pwd)/obsidian-init.sh\"" >> ~/.config/fish/config.fish
source ~/.config/fish/config.fish
```

### Windows (PowerShell)

```powershell
git clone https://github.com/thintime-dev/obsidian-init.git
```

添加函数到 PowerShell 配置文件

```powershell
# 打开 PowerShell 配置文件（如不存在会自动创建）
if (!(Test-Path $PROFILE)) { New-Item -Path $PROFILE -Force }
notepad $PROFILE
```

在配置文件中添加以下内容（将路径替换为实际克隆路径）：
```powershell
function obsidian-init {
    param([string]$Source)
    if ($Source) {
        & "C:\path\to\obsidian-init\obsidian-init.ps1" -Source $Source
    } else {
        & "C:\path\to\obsidian-init\obsidian-init.ps1"
    }
}
```

保存后重启 PowerShell 或执行：
```powershell
. $PROFILE
```

## Usage

### Linux / macOS

```bash
# 进入需要初始化 Obsidian 的仓库
cd /path/to/your/vault

# 使用默认配置源初始化
obsidian-init

# 或者指定自定义配置源目录（该目录下应包含 .obsidian 文件夹）
obsidian-init /path/to/source-directory
```

### Windows (PowerShell)

```powershell
# 进入需要初始化 Obsidian 的仓库
cd C:\path\to\your\vault

# 使用默认配置源初始化
obsidian-init

# 或者指定自定义配置源目录
obsidian-init -Source "C:\path\to\source-directory"
```

## Configuration

默认配置源路径：

| 平台 | 默认路径 |
|------|----------|
| Linux/macOS | `~/Projects/dotfiles/obsidian` |
| Windows | `%USERPROFILE%\Projects\dotfiles\obsidian` |

脚本会从该目录下复制 `.obsidian` 文件夹。

如需修改默认路径：
- **Linux/macOS**: 编辑 `obsidian-init.sh` 中的 `DEFAULT_SOURCE` 变量
- **Windows**: 编辑 `obsidian-init.ps1` 中的 `$Source` 默认值

