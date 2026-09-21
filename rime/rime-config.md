# Rime 输入法配置

## 配置文件说明

### Linux / Fcitx5

Fcitx5 的 Rime 用户目录为 `~/.local/share/fcitx5/rime/`。本仓库只保存跨平台用户补丁：

- `default.custom.yaml`
- `rime_ice.custom.yaml`

Fcitx5 的候选窗配置不读取 `squirrel.custom.yaml` 或 `weasel.custom.yaml`。Linux 专用的候选窗配置位于 `../fcitx5/`，包括 Classic UI 主题、字体和输入法 profile。安装 Rime 和 Fcitx5 后运行：

```bash
cd ../fcitx5
./install-linux.sh
```

脚本不会同步 Rime Ice 的词库、`build/`、用户词频数据库或其他生成文件。


## 安装步骤

### 1. 安装 Rime 输入法

- **Windows**: 下载 [Weasel](https://github.com/rime/weasel/releases) 并安装
- **macOS**: 下载 [Squirrel](https://github.com/rime/squirrel/releases) 并安装

### 2. 安装雾凇拼音

```bash
git clone --depth=1 https://github.com/rime/plum
cd plum
bash rime-install iDvel/rime-ice:others/recipes/full
```

### 3. 复制配置文件

#### Windows

Rime 配置目录：`%APPDATA%\Rime\`

1. 复制 `weasel.custom.yaml`
2. 复制 `default.custom.yaml`
3. 复制 `rime_ice.custom.yaml`
4. 重新部署 Rime（右键托盘图标 → 重新部署）

#### macOS

Rime 配置目录：`~/Library/Rime/`

1. 复制 `squirrel.custom.yaml`
2. 复制 `default.custom.yaml`
3. 复制 `rime_ice.custom.yaml`
4. 重新部署 Rime（菜单栏输入法图标 → 重新部署）

## 配置内容说明

### 外观配置（squirrel.custom.yaml / weasel.custom.yaml）

- macOS/Windows 客户端使用各自的候选窗配置
- 候选词水平排列
- 单行显示候选
- Linux Fcitx5 使用 `../fcitx5/themes/jwu/theme.conf` 实现对应样式

### 按键配置 + 输入方案配置（default.custom.yaml）

- 候选词水平排列
- 单行显示候选
- 与外观配置相同的配色方案
