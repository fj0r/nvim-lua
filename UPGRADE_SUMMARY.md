# Neovim 0.12 内置包管理器迁移完成总结

## 概述

已完成将 Neovim 配置从 lazy.nvim 迁移到 Neovim 0.12+ 内置包管理器的工作。
manifest 目录中的插件配置保持不变，使用外部 nushell 脚本管理插件仓库。

---

## 文件变更清单

### 新增文件

| 文件 | 用途 |
|------|------|
| `lua/package_helper.lua` | 内置包管理器辅助模块，模拟 lazy.nvim 行为 |
| `scripts/plugins.nu` | 插件管理 nushell 脚本（安装/更新/同步/清理） |
| `scripts/init.sh` | Bash 初始化脚本（可选使用） |
| `PLUGINS.md` | 插件使用指南 |
| `MIGRATION.md` | 迁移指南文档 |
| `UPGRADE_SUMMARY.md` | 本文档 |

### 修改文件

| 文件 | 变更说明 |
|------|----------|
| `init.lua` | 移除 lazy.nvim 加载逻辑，改用内置包管理器 |
| `lua/lazy_helper.lua` | 改为兼容层，重定向到 package_helper |
| `.gitignore` | 添加 `plugins/` 目录忽略 |
| `,.nu` | 添加插件管理快捷命令 |
| `.git_gc.sh` | 更新为清理新的插件目录 |

### 保持不变的目录

| 目录 | 说明 |
|------|------|
| `lua/manifest/` | **所有文件保持不变** |
| `lua/settings/` | **所有配置文件保持不变** |
| `lua/common/` | **所有文件保持不变** |
| `lua/other/` | **所有文件保持不变** |

---

## 目录结构

```
nvim/
├── pack/
│   └── pafo/
│       ├── start/          # 启动加载插件（符号链接）
│       └── opt/            # 按需加载插件（符号链接）
├── plugins/                # 插件 git 仓库（新）
├── scripts/
│   ├── plugins.nu          # 插件管理脚本（新）
│   └── init.sh             # Bash 初始化脚本（新）
├── lua/
│   ├── package_helper.lua  # 包管理器辅助模块（新）
│   ├── lazy_helper.lua     # 兼容层（已修改）
│   ├── manifest/           # 插件配置（不变）
│   └── settings/           # 插件设置（不变）
├── init.lua                # 主配置（已修改）
├── PLUGINS.md              # 使用指南（新）
├── MIGRATION.md            # 迁移指南（新）
└── UPGRADE_SUMMARY.md      # 本文档（新）
```

---

## 使用方法

### 初始化（首次使用）

```bash
# 使用 nushell
nu scripts/plugins.nu init
nu scripts/plugins.nu install

# 或使用 bash
bash scripts/init.sh
```

### 日常操作

```bash
# 安装/更新所有插件
nu scripts/plugins.nu install
# 或
plugins install
# 或简写
pi

# 查看插件列表
nu scripts/plugins.nu list
# 或
pl

# 查看状态
nu scripts/plugins.nu status
# 或
ps

# 更新单个插件
nu scripts/plugins.nu update <plugin-name>

# 同步插件到 pack 目录
nu scripts/plugins.nu sync

# 清理已禁用插件
nu scripts/plugins.nu clean
```

---

## 工作原理

### 插件加载流程

1. `init.lua` 扫描 `pack/pafo/start` 和 `pack/pafo/opt` 目录
2. 将插件目录添加到 `runtimepath`
3. 加载 `lua/manifest/*.lua` 中的插件配置
4. 执行 `config` 和 `opts` 选项
5. 触发 `VeryLazy` 事件

### 插件管理流程

1. `plugins.nu` 解析 `lua/manifest/*.lua` 文件
2. 提取插件名称、tag、event、enabled 等信息
3. 克隆/更新 git 仓库到 `plugins/` 目录
4. 创建符号链接到 `pack/pafo/start` 或 `pack/pafo/opt`
5. 根据 `event` 选项决定加载类型（start/opt）

---

## lazy.nvim 兼容性

### 支持的 API

```lua
local h = require('lazy_helper')

-- 检查插件
h.has_plugin('plugin-name')
h.all_plugin()
h.plugins()

-- 应用按键映射
h.apply_keymap(kdecl, kdef, opt)

-- 配置包装
h.settings 'plugin-name'

-- 新增功能
h.get_plugin_dir('plugin-name')
h.load('plugin-name')
h.is_loaded('plugin-name')
```

### 支持的插件选项

| 选项 | 说明 | 支持状态 |
|------|------|----------|
| `enabled` | 启用/禁用 | ✅ |
| `event` | 触发事件 | ✅ |
| `tag` | Git 标签/版本 | ✅ |
| `config` | 配置函数 | ✅ |
| `opts` | 配置表 | ✅ |
| `dependencies` | 依赖 | ⚠️ 记录但不自动处理 |

---

## 注意事项

### 符号链接

- Linux/Mac: 默认支持
- Windows: 需要管理员权限或使用开发者模式

### Git 仓库

- 所有插件仓库存储在 `plugins/` 目录
- 使用 `--depth 1` 浅克隆减少下载量
- 指定 `tag` 时会切换到特定版本

### 性能

- 启动时扫描 `pack/` 目录
- 按需加载插件减少启动时间
- 符号链接减少磁盘占用

---

## 故障排除

### 常见问题

1. **插件未加载**
   ```bash
   nu scripts/plugins.nu sync
   ```

2. **符号链接失效**
   ```bash
   nu scripts/plugins.nu clean
   nu scripts/plugins.nu sync
   ```

3. **配置错误**
   ```bash
   nvim -V3log.txt
   ```

### 调试命令

```vim
" 查看 runtimepath
:echo &runtimepath

" 检查插件是否加载
:lua print(require('package_helper').has_plugin('plugin-name'))

" 查看插件列表
:lua print(vim.inspect(require('package_helper').plugins()))
```

---

## 下一步

1. ✅ 运行 `nu scripts/plugins.nu init` 初始化目录
2. ✅ 运行 `nu scripts/plugins.nu install` 安装插件
3. ✅ 启动 Neovim 测试配置
4. ✅ 检查 `:messages` 确认无错误
5. ⬜ 删除旧的 `lazy/` 目录（可选）

---

## 参考文档

- `PLUGINS.md` - 详细使用指南
- `MIGRATION.md` - 迁移指南和故障排除
- [Neovim 包管理器文档](https://neovim.io/doc/user/repeat.html#packages)