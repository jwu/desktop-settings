# Rime 输入法配置

## 配置文件说明

### 源文件

| 源文件 | 说明 |
|--------|------|
| `rime.custom.yaml` | 外观配置 |
| `rime.default.custom.yaml` | 按键配置 + 输入方案配置 |

### 目标文件名（按平台）

| 平台 | rime.custom.yaml → | rime.default.custom.yaml → |
|------|-------------------|---------------------------|
| macOS | `squirrel.custom.yaml` | `default.custom.yaml` |
| Windows | `weasel.custom.yaml` | `default.custom.yaml` |

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

1. 将 `rime.custom.yaml` 复制并重命名为 `weasel.custom.yaml`
2. 将 `rime.default.custom.yaml` 复制并重命名为 `default.custom.yaml`
3. 重新部署 Rime（右键托盘图标 → 重新部署）

#### macOS

Rime 配置目录：`~/Library/Rime/`

1. 将 `rime.custom.yaml` 复制并重命名为 `squirrel.custom.yaml`
2. 将 `rime.default.custom.yaml` 复制并重命名为 `default.custom.yaml`
3. 重新部署 Rime（菜单栏输入法图标 → 重新部署）

## 配置内容说明

### 外观配置（squirrel.custom.yaml / weasel.custom.yaml）

- 基于：冷漠／Apathy
- 候选词水平排列
- 单行显示候选
- 自定义配色：
  - 候选文字：#EE6E00
  - 候选背景：#FFF0E4
  - 提示文字：#999999

### 按键配置 + 输入方案配置（default.custom.yaml）

- 候选词水平排列
- 单行显示候选
- 与外观配置相同的配色方案
