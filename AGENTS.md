# AGENTS.md - 桌面设置仓库

跨平台桌面配置仓库：Windows、macOS、Linux 的桌面应用与输入法设置。没有构建系统，
可执行逻辑是 `fcitx5/` 下的两个脚本：`install-linux.sh` 与 `update-rime-dict.sh`。

## 仓库结构

| 目录 | 内容 | 说明 |
| --- | --- | --- |
| `totalcmd/` | `wincmd.ini` | Total Commander 配置（INI） |
| `zed/` | `settings.json` | Zed 编辑器设置 |
| `obsidian/` | `template-vault/` | Obsidian 保险库模板 |
| `inputsource-pro/` | 说明与截图 | macOS 输入法切换（Input Source Pro） |
| `aerospace/` | `.aerospace.toml` | macOS 平铺窗口管理 |
| `mac/` | `install.sh` | macOS 同步脚本（AeroSpace、Zed） |
| `fcitx5/` | `profile`、`classicui.conf`、`themes/jwu/` | Linux Fcitx5 与候选窗主题 |
| `rime/` | `*.custom.yaml` | Rime（Ice）用户补丁 |

每个目录下都有对应的 `*-config.md` 说明文档。

## 安装脚本

两组脚本都是 Bash + `set -euo pipefail`，覆盖前备份为 `.bak.$TIMESTAMP`，保持可重复执行。

`mac/install.sh`：

- 同步 `aerospace/.aerospace.toml` 到 `~/.aerospace.toml`、`zed/settings.json` 到
  `~/.config/zed/settings.json`
- 检测到 `aerospace` 命令时执行 `aerospace reload-config`
- Input Source Pro、Obsidian、Total Commander 不在脚本范围内
- 改动后验证：`bash -n mac/install.sh`

`fcitx5/install-linux.sh`：

- 只同步用户补丁（`profile`、`classicui.conf`、主题、`rime/*.custom.yaml`），覆盖前备份为
  `.bak.$TIMESTAMP`
- Rime Ice 词库不进仓库：`rime_ice.schema.yaml` 缺失时下载解压（不清空用户目录），
  但绝不覆盖 `build/`、用户词频数据库和 Fcitx5 键盘缓存
- 改动后验证：`bash -n fcitx5/install-linux.sh`

`fcitx5/update-rime-dict.sh`：

- 拉取上游 Rime Ice 最新 `full.zip`（**GitHub 官方优先**，失败回退南大镜像，
  并用官方 release digest 校验 sha256）覆盖解压到 `~/.local/share/fcitx5/rime`，
  先把用户目录里的 `*.custom.yaml` 备份为 `.bak.$TIMESTAMP`，再调用 `install-linux.sh`
  重新应用补丁并重建
- 南大镜像是缓存，可能滞后数周（实测 2026-06-30 vs 上游 2026-09-25），因此不作为首选；
  校验不通过会自动回退官方源
- `--mirror` 镜像优先；`--no-deploy` 只更新词库与补丁，不重建/重载
- 改动后验证：`bash -n fcitx5/update-rime-dict.sh`

## 文件格式规范

### Total Commander（INI）

- 节标题用 `[SectionName]`；键值对 `Key=Value`，`=` 周围不加空格
- 相关设置分组放到对应节下；需要说明时用 `;` 前缀注释
- 热键在 `[Shortcuts]` 中定义，格式 `KeyCombination=CommandName`，使用标准命令名
  （如 `cm_EditPath`、`cm_RenameOnly`）
- 颜色用十进制 RGB（如 `16744448`）；特殊值 `-1` 系统默认、`0` 禁用，行内注释记录
- 窗口几何 `Key=X,Y,Width,Height`；分辨率节 `[WidthxHeight]`；
  显示器条目 `monitor(index,x,y,width,height;dpi)=geometry`

### Fcitx5 / Rime

- `rime/*.custom.yaml` 只保留对上游配置的补丁，不整文件复制
- 修改后由脚本调用 `rime_deployer --build` 重建（若可用）

## 版本控制

- 使用描述性提交消息，相关改动尽量合并到一次提交
- 配置更新无需代码审查
