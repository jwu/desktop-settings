# AGENTS.md - 桌面设置仓库

本仓库包含 Total Commander 配置文件（wincmd.ini），不是一个代码项目。没有构建系统、lint 或测试流程。

## 仓库用途

这是一个仅用于存储 Total Commander 设置的配置仓库。主要文件是 `wincmd.ini` - Total Commander 的 INI 格式配置文件。

## 无需构建/Lint/测试命令

本仓库不包含可执行代码，不需要构建、lint 或测试命令。

## 代码风格指南

### INI 文件规范

- 使用 `[SectionName]` 格式的节标题
- 键值对保持 `Key=Value` 格式，`=` 周围不加空格
- 在节块内使用一致的缩进以提高可读性
- 将相关设置分组放在适当的节标题下
- 需要说明时使用 `;` 前缀添加注释

### 热键定义

- 在 `[Shortcuts]` 节中定义自定义快捷键
- 格式：`KeyCombination=CommandName`
- 使用标准的 Total Commander 命令名（如 `cm_EditPath`、`cm_RenameOnly`）
- 保持热键组合直观一致

### 颜色设置

- 颜色值使用十进制 RGB 格式（如 `16744448` 表示特定蓝色）
- 特殊值：`-1` 表示系统默认，`0` 表示禁用
- 使用行内注释记录自定义颜色选择

### 窗口位置

- 窗口几何格式为 `Key=X,Y,Width,Height`
- 分辨率特定节使用 `[WidthxHeight]` 格式
- 显示器特定条目使用 `monitor(index,x,y,width,height;dpi)=geometry` 格式

## 文件组织

- `wincmd.ini` - Total Commander 主配置文件
- `totalcmd-config.md` - 配置说明文档
- `images/` - 配置说明截图

## 版本控制

- 使用描述性消息提交配置更改
- 尽可能将相关更改分组在单次提交中
- 配置更新不需要代码审查
