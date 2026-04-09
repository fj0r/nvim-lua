# 从 lazy.nvim 迁移到内置包管理器

本文档说明如何将 Neovim 配置从 lazy.nvim 迁移到 Neovim 0.12+ 的内置包管理器。

## 迁移概述

| 组件 | lazy.nvim | 内置包管理器 |
|------|-----------|-------------|
| 插件目录 | `lazy/packages/` | `plugins/` |
| 加载方式 | Lua 动态加载 | `pack/` 目录结构 |
| 配置位置 | `lua/manifest/` | 保持不变 |
| 管理工具 | `:Lazy` 命令 | `scripts/plugins.nu` |

## 迁移步骤

### 1. 备份当前配置（可选但推荐）

```bash
cd ~/.config/nvim
git add .
git commit -m "pre-migration backup"
```

### 2. 初始化新目录结构

```bash
nu scripts/plugins.nu init
```

或手动创建：
```bash
mkdir -p plugins
mkdir -p pack/pafo/start
mkdir -p pack/pafo/opt
```

### 3. 安装插件

```bash
nu scripts/plugins.nu install
```

这会：
- 读取 `lua/manifest/*.lua` 中的插件配置
- 克隆所有启用的插件到 `plugins/` 目录
- 创建符号链接到 `pack/pafo/start` 或 `pack/pafo/opt`

### 4. 清理旧文件

```bash
# 删除 lazy 目录（如果存在）
rm -rf lazy/
rm -f lazy-lock.json
```

### 5. 验证迁移

```bash
nu scripts/plugins.nu status
```

启动 Neovim 检查：
```bash
nvim
# 在 Neovim 中运行
:messages
```

## 主要变化

### init.lua

**之前（lazy.nvim）：**
```lua
local lazypath = vim.g.config_root .. '/lazy/lazy.nvim'
-- 克隆 lazy.nvim
require('lazy').setup('manifest', { root = lazyhome .. '/packages' })
```

**之后（内置包管理器）：**
```lua
local pack_root = vim.g.config_root .. '/pack/pafo'
-- 自动扫描 pack 目录
require('package_helper')
-- 加载 manifest 配置
```

### 插件目录结构

**之前：**
```
lazy/
├── lazy.nvim/
└── packages/
    └── plugin-name/
```

**之后：**
```
plugins/
└── plugin-name/          # git 仓库

pack/pafo/
├── start/
│   └── plugin-name -> ../../plugins/plugin-name
└── opt/
    └── plugin-name -> ../../plugins/plugin-name
```

### 管理命令

| 功能 | lazy.nvim | 内置包管理器 |
|------|-----------|-------------|
| 安装插件 | `:Lazy install` | `nu scripts/plugins.nu install` |
| 更新插件 | `:Lazy update` | `nu scripts/plugins.nu update <name>` |
| 查看状态 | `:Lazy` | `nu scripts/plugins.nu status` |
| 清理插件 | `:Lazy clean` | `nu scripts/plugins.nu clean` |

## 兼容性

### 保持不变的

- ✅ `lua/manifest/` 目录中的所有文件
- ✅ `lua/settings/` 目录中的配置
- ✅ `lazy_helper.lua` API（已重定向到 `package_helper`）
- ✅ 插件配置格式（`enabled`, `event`, `tag`, `config`, `opts`）

### 需要注意的

- ⚠️ 符号链接需要文件系统支持
- ⚠️ Windows 需要管理员权限创建符号链接
- ⚠️ 某些 lazy 特定功能可能不可用

## 故障排除

### 插件未加载

1. 检查符号链接是否正确：
   ```bash
   ls -la pack/pafo/start/
   ls -la pack/pafo/opt/
   ```

2. 检查 runtimepath：
   ```vim
   :echo &runtimepath
   ```

3. 重新同步插件：
   ```bash
   nu scripts/plugins.nu sync
   ```

### 配置错误

1. 查看详细日志：
   ```bash
   nvim -V3log.txt
   ```

2. 检查 Neovim 版本：
   ```vim
   :version
   ```

3. 禁用所有插件测试：
   ```bash
   mv pack/pafo pack/pafo.bak
   nvim
   ```

### 符号链接问题

**Linux/Mac:**
```bash
# 检查是否支持符号链接
ln -s /tmp/test /tmp/test-link
```

**Windows:**
```powershell
# 需要管理员权限
New-Item -ItemType SymbolicLink -Path ...
```

## 回退到 lazy.nvim

如果需要回退：

1. 恢复 lazy 目录：
   ```bash
   git checkout lazy/
   ```

2. 恢复 init.lua：
   ```bash
   git checkout init.lua
   ```

3. 删除新文件：
   ```bash
   rm -rf plugins/ pack/ lua/package_helper.lua scripts/plugins.nu
   ```

## 快捷命令

在 nushell 中添加别名：

```nushell
alias pi = plugins install
alias pu = plugins update
alias ps = plugins status
alias pl = plugins list
alias pc = plugins clean
```

## 资源

- [Neovim 包管理器文档](https://neovim.io/doc/user/repeat.html#packages)
- [内置包系统详解](https://neovim.io/doc/user/usr_05.html#05.5)