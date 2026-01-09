# obsidian-init - 一键初始化 Obsidian 配置 (Windows)
# 用法: obsidian-init [源配置目录路径]

param(
    [string]$Source = "$env:USERPROFILE\Projects\dotfiles\obsidian"
)

# 源 .obsidian 目录的完整路径
$SourceObsidian = Join-Path $Source ".obsidian"

# 目标路径为当前目录下的 .obsidian
$Target = Join-Path (Get-Location) ".obsidian"

# 检查源 .obsidian 目录是否存在
if (-not (Test-Path $SourceObsidian -PathType Container)) {
    Write-Host "Error: 源配置目录不存在: $SourceObsidian" -ForegroundColor Red
    exit 1
}

# 检查目标 .obsidian 是否已存在
if (Test-Path $Target) {
    $confirm = Read-Host "Warning: 目标目录已存在 $Target`n是否覆盖? [y/N]"
    if ($confirm -match '^[yY]([eE][sS])?$') {
        Remove-Item -Path $Target -Recurse -Force
    } else {
        Write-Host "已取消操作"
        exit 0
    }
}

try {
    Copy-Item -Path $SourceObsidian -Destination $Target -Recurse -Force
    Write-Host "Success: .obsidian 配置已复制到 $Target" -ForegroundColor Green
} catch {
    Write-Host "Error: 复制失败 - $_" -ForegroundColor Red
    exit 1
}
