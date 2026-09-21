# Desktop Settings

个人桌面配置文件仓库

## 字体配置

- UI 界面字体：Inter
- 中文字体：
  - Windows：Microsoft YaHei
  - macOS：PingFang SC

## Total Commander 配置

将 `totalcmd/wincmd.ini` 复制到 `~\AppData\Roaming\GHISLER\` 即可使用。

详细配置说明请参考 [totalcmd-config](./totalcmd/totalcmd-config.md)。

## Zed 配置

将 `zed/settings.json` 复制到对应平台的 Zed 配置目录。

详细同步方法请参考 [zed-config](./zed/zed-config.md)。

## Obsidian 配置

打开 `obsidian/template-vault` 作为 Obsidian 保险库。

详细说明请参考 [obsidian-config](./obsidian/obsidian-config.md)。

## Input Source Pro 配置（MacOS）

使用 Homebrew 安装：

```bash
brew install --cask input-source-pro
```

详细说明请参考 [inputsource-pro-config](./inputsource-pro/inputsource-pro-config.md)。

## AeroSpace 配置（MacOS）

将 `aerospace/.aerospace.toml` 复制到 `~/.aerospace.toml`。

详细说明请参考 [aerospace-config](./aerospace/aerospace-config.md)。

### Linux 桌面配置

Linux 下的 Niri、Hyprland、Ghostty 和输入法环境配置保存在相邻的 `configs` 仓库中：

- `configs/linux/.config/niri/config.kdl`：Niri 输出、布局、启动项和快捷键
- `configs/linux/.config/hypr/hyprland.lua`：备用 Hyprland 配置
- `configs/linux/.config/ghostty/config.ghostty`：Ghostty 字体、颜色和快捷键
- `configs/linux/.config/environment.d/fcitx5.conf`：GTK、Qt 和 XMODIFIERS 输入法环境变量

`configs/linux/config.sh` 会在对应程序已安装时同步这些配置。Niri 和 Ghostty 会在重新启动程序后读取新配置。

### Fcitx5 / Rime Linux 配置

Linux 专用的 Fcitx5 配置位于 `fcitx5/`：

- `fcitx5/profile`：启用 `keyboard-us` 和 Rime
- `fcitx5/classicui.conf`：横向候选列表、字体和主题
- `fcitx5/themes/jwu/theme.conf`：白底、蓝色高亮和灰色注释
- `fcitx5/install-linux.sh`：同步 Fcitx5 和 Rime 用户配置

安装 Fcitx5、`fcitx5-rime` 和 Rime Ice 后运行：

```bash
cd ~/bin/desktop-settings/fcitx5
./install-linux.sh
```

脚本只同步用户补丁和候选窗配置，不提交或覆盖 Rime Ice 词库、`build/`、用户词频数据库和 Fcitx5 的键盘缓存。

## Reference

- Fonts
  - [Inter](https://rsms.me/inter/)
  - Microsoft YaHei
  - PingFang SC
- Coding
  - [Zed](https://zed.dev/)
  - [Neovide](https://neovide.dev/)
- Version Control
  - [GitButler](https://www.gitbutler.com/)
- Documentation
  - [Obsidian](https://obsidian.md/)
  - [Logseq](https://logseq.com/)
- File Management
  - [Total Commander](https://www.ghisler.com/)
- Window Management
  - MacOS
    - [AeroSpace](https://github.com/nikitabobko/AeroSpace)
- System Tools
  - [7-Zip](https://www.7-zip.org/)
  - Windows
    - [Everything](https://www.voidtools.com/)
      - [Everything CLI](https://www.voidtools.com/support/everything/command_line_interface/)
  - MacOS
    - [Input Source Pro](https://inputsource.pro/)
    - [AutoRise](https://autorie.app/)
- Screen Capture
  - [Snipaste](https://www.snipaste.com/)
    - [ShareX](https://getsharex.com/)
- Image Viewer
  - [PureRef](https://www.pureref.com/)
  - [IrfanView](https://www.irfanview.com/)
    - [qView](https://interversehq.com/qview/)
- Media Players
  - [iina](https://github.com/iina/iina)
  - [PortPlayer](https://portplayer.net/)
  - [VLC](https://www.videolan.org/vlc/)
- Media Recorder
  - [OBS Studio](https://obsproject.com/)
  - [OpenScreen](https://openscreen.vercel.app/)
- VPN
  - [Clash Verge](https://github.com/clash-verge-rev/clash-verge-rev)
    - [WgetCloud](https://wgetcloud.org/)
- Remote Desktop
  - [RustDesk](https://rustdesk.com/)
