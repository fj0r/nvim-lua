# Neovim 内置包管理器使用指南

本文档说明如何使用 Neovim 0.12+ 的内置包管理器替代 lazy.nvim。

## 目录结构

```
nvim/
├── pack/
│   └── pafo/
│       ├── start/          # 启动时加载的插件（符号链接）
│       └── opt/            # 按需加载的插件（符号链接）
├── plugins/                # 插件 git 仓库目录
├── scripts/
│   └── plugins.nu          # 插件管理脚本
├── lua/
│   ├── package_helper.lua  # lazy.nvim 兼容层
│   ├── lazy_helper.lua     # 向后兼容接口
│   └── manifest/           # 插件配置（保持不变）
└── init.lua                # 主配置文件
```

## 快速开始

### 1. 初始化目录结构

```bash
nu scripts/plugins.nu init
```

或使用快捷命令：
```bash
plugins init
```

### 2. 安装/更新所有插件

```bash
nu scripts/plugins.nu install
```

或：
```bash
plugins install
# 或简写
pi
```

### 3. 查看插件列表

```bash
nu scripts/plugins.nu list
# 或
pl
```

### 4. 查看插件状态

```bash
nu scripts/plugins.nu status
# 或
ps
```

## 命令说明

| 命令 | 说明 |
|------|------|
| `plugins.nu init` | 初始化目录结构 |
| `plugins.nu install` | 安装/更新所有启用的插件 |
| `plugins.nu update <name>` | 更新指定插件 |
| `plugins.nu sync` | 同步插件到 pack 目录 |
| `plugins.nu list` | 列出所有插件（启用/禁用） |
| `plugins.nu clean` | 清理已禁用的插件 |
| `plugins.nu status` | 显示当前状态 |

## 工作原理

### 插件加载流程

1. **扫描 manifest** - `init.lua` 加载 `lua/manifest/` 目录中的所有插件配置
2. **添加到 runtimepath** - 将 `pack/pafo/start` 和 `pack/pafo/opt` 中的插件添加到 `runtimepath`
3. **执行配置** - 根据 manifest 中的 `config` 和 `opts` 选项执行插件配置
4. **延迟加载** - 支持 `event` 选项的按需加载

### 插件仓库管理

- 所有插件 git 仓库存储在 `plugins/` 目录
- `pack/` 目录使用符号链接指向实际仓库
- 支持 `tag` 选项指定特定版本

### lazy.nvim 兼容性

`lua/lazy_helper.lua` 提供了与 lazy.nvim 相同的 API：

```lua
local h = require('lazy_helper')

return {
    {
        'owner/repo',
        enabled = true,
        event = 'VeryLazy',
        tag = '1.0.0',
        config = h.settings 'plugin-name',
        opts = {},
    }
}
```

**支持的选项：**
- `enabled` - 启用/禁用插件
- `event` - 触发事件（如 `VeryLazy`, `BufRead` 等）
- `tag` - Git 标签/版本
- `config` - 配置函数
- `opts` - 插件配置表

## 常见问题

### Q: 如何添加新插件？

在 `lua/manifest/` 目录下的任意文件中添加插件定义：

```lua
return {
    {
        'new/plugin',
        config = h.settings 'plugin-name',  -- 如果有 settings 文件
        -- 或
        config = function()
            require('plugin').setup()
        end
    }
}
```

然后运行：
```bash
plugins install
```

### Q: 如何禁用插件？

在 manifest 中设置 `enabled = false`：

```lua
{
    'owner/repo',
    enabled = false
}
```

然后运行：
```bash
plugins clean
```

### Q: 如何更新单个插件？

```bash
nu scripts/plugins.nu update plugin-name
```

### Q: 如何切换到特定版本？

在 manifest 中指定 `tag`：

```lua
{
    'owner/repo',
    tag = 'v1.2.3'
}
```

然后运行：
```bash
plugins install
```

### Q: 插件配置在哪里？

插件配置位于 `lua/settings/` 目录，与 manifest 中的 `config = h.settings 'name'` 对应。

## 调试

### 查看加载的插件

在 Neovim 中运行：
```vim
:echo &runtimepath
```

### 查看插件目录

```vim
:lua print(vim.inspect(require('package_helper').plugins()))
```

### 检查插件是否加载

```vim
:lua print(require('package_helper').has_plugin('plugin-name'))
```

### 查看详细日志

启动 Neovim 时添加 `-V` 参数：
```bash
nvim -V3log.txt
```

## 从 lazy.nvim 迁移

1. 运行 `plugins init` 初始化目录
2. 运行 `plugins install` 安装插件
3. 删除 `lazy/` 目录（可选）
4. 更新 `.gitignore`（已完成）
5. 重启 Neovim 测试

## 注意事项

- **不要修改** `lua/manifest/` 目录中的文件
- 插件配置保持原有格式，无需修改
- 首次安装后需要重启 Neovim
- 符号链接需要文件系统支持（Windows 需要管理员权限）